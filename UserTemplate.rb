module Rollr
  class Template

    # Holy wozers!
    CACHE_DIR = File.join(
      # ~/Library/Application Support
      *NSFileManager.defaultManager.URLsForDirectory(
        NSApplicationSupportDirectory,
        inDomains: NSUserDomainMask
      ).first.pathComponents,
      # Rollr
      NSBundle.mainBundle.infoDictionary['CFBundleName']
    ).tap {|dir| FileUtils.mkdir_p dir}


    attr_reader :path, :site

    def path= url
      @path = File.join *NSURL.URLWithString(url).pathComponents
      trigger 'Updated:Path'
      trigger 'Updated'
      @path
    end

    def site= url
      @site = NSURL.URLWithString(url)
      trigger 'Updated:Site'
      trigger 'Updated'
      @site
    end

    def host
      site.host || site.path
    end

    def name
      File.basename path
    end

    def public_path
      directory
    end

    def view_path
      directory
    end

    def incomplete?
      path && site
    end

    def data_path
      File.join(CACHE_DIR, "#{host}.json").tap do |path|
        unless File.exist? path
          raw = fetch_and_format(host)
          File.open(path, 'w') do |f|
            f.write raw
          end
        end
      end
    end

  private

    def directory
      File.dirname path
    end

    def fetch_and_format host
      api_read_url = URI::HTTP.build :host => host, :path => '/api/read/json'
      api_pages_url = URI::HTTP.build :host => host, :path => '/api/pages'

      # begin
      #   api_read_raw = RestClient.get api_read_url.to_s
      # rescue RestClient::Exception => e
      #   abort "Error fetching #{api_read_url}"
      # end

      api_read_raw.sub! /^var tumblr_api_read = /, ''
      api_read_raw.sub! /;$/, ''

      data = JSON.parse api_read_raw

      # begin
      #   api_pages_raw = RestClient.get api_pages_url.to_s
      # rescue RestClient::Exception => e
      #   abort "Error fetching #{api_pages_url}"
      # end

      pages_doc = Nokogiri::XML(api_pages_raw)

      data['pages'] = pages_doc.xpath('//pages').children.to_a.map {|page|
        case page.name
        when 'page'
          {'render-in-theme' => page['render-in-theme'] == 'true',
           'title' => page['title'],
           'content' => page.content
          }
        when 'redirect'
          {'redirect-to' => page['redirect-to']
          }
        end.merge(
          'url' => URI.parse(page['url']).path,
          'label' => page['link-title']
        ).reject {|k,v| not v}
      }
      data
    end

  end
end
