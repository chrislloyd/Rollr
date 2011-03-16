class UserTemplate

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

  def initialize
    @fetching = false
  end


  def path= url
    @path = File.join *NSURL.URLWithString(url).pathComponents
  end

  def site= url
    @site = NSURL.URLWithString(url)
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

  def data_path
    File.join(CACHE_DIR, "#{host}.json").tap do |path|
      unless File.exist? path
        trigger 'Loading' && @fetching = true

        raw = fetch_and_format!
        File.open(path, 'w') do |f|
          f.write raw
        end
        @fetching = false
      end
    end
  end

  def data_exists?
    File.exist? data_path
  end

  def complete?
    path && site && !@fetching && data_exists?
  end

private

  def directory
    File.dirname path
  end

  # TODO Refactor
  def fetch_and_format!
    api_read_url = NSURL.alloc.initWithScheme 'http', host: host,
                                                      path: '/api/read/json'
    api_pages_url = NSURL.alloc.initWithScheme 'http', host: host,
                                                       path: '/api/pages'

    # Default cache and 60s timeout
    response = NSURLRequest.requestWithURL api_read_url

    puts response.HTTPBody

    # NSURLRequest.requestWithURL site, cachePolicy:timeoutInterval:
    #
    # # begin
    # #   api_read_raw = RestClient.get api_read_url.to_s
    # # rescue RestClient::Exception => e
    # #   abort "Error fetching #{api_read_url}"
    # # end
    #
    # api_read_raw.sub! /^var tumblr_api_read = /, ''
    # api_read_raw.sub! /;$/, ''
    #
    # data = JSON.parse api_read_raw
    #
    # # begin
    # #   api_pages_raw = RestClient.get api_pages_url.to_s
    # # rescue RestClient::Exception => e
    # #   abort "Error fetching #{api_pages_url}"
    # # end
    #
    # pages_doc = Nokogiri::XML(api_pages_raw)
    #
    # data['pages'] = pages_doc.xpath('//pages').children.to_a.map {|page|
    #   case page.name
    #   when 'page'
    #     {'render-in-theme' => page['render-in-theme'] == 'true',
    #      'title' => page['title'],
    #      'content' => page.content
    #     }
    #   when 'redirect'
    #     {'redirect-to' => page['redirect-to']
    #     }
    #   end.merge(
    #     'url' => URI.parse(page['url']).path,
    #     'label' => page['link-title']
    #   ).reject {|k,v| not v}
    # }
    # data
  end

end
