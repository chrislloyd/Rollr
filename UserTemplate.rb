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
    cache_path
  end

  def data_exists?
    File.exist? cache_path
  end

  def complete?
    path && site && data_exists?
  end

  def fetch_and_cache_data!
    puts 'starting fetch'
    fetch_tumblr_api do |tumblelog|
      puts 'got /api/read'
      fetch_tumblr_pages_api do |pages|

        # tumblelog[:pages] = pages
        #
        File.open(cache_path, 'w') {|f| f.write tumblelog.to_json}

        trigger 'DataFetched'
      end
    end

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

private

  def cache_path
    File.join CACHE_DIR, "#{host}.json"
  end

  def directory
    File.dirname path
  end

  def tumblr_api_url
    NSURL.alloc.initWithScheme 'http', host: host, path: '/api/read/json'
  end

  def tumblr_pages_api_url
    NSURL.alloc.initWithScheme 'http', host: host, path: '/api/pages'
  end

  def fetch_tumblr_api &callback
    tumblr_api_url.fetch do |data|
      payload = NSMutableString.alloc.initWithData(data, encoding: NSUTF8StringEncoding)

      payload.sub! /^var tumblr_api_read = /, ''
      payload.sub! /;$/, ''

      callback.call JSON.parse(payload)
    end
  end

  def fetch_tumblr_pages_api &callback
    HTTPRequest.start tumblr_pages_api_url do |data|
      payload = NSString.alloc.initWithData(data, encoding: NSUTF8StringEncoding)

      callback.call payload
    end
  end

end
