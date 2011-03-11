require 'uri'
require 'sanitize'

module Thud
  module Helpers

    PORTRAIT_SIZES = [16, 24, 30, 40, 46, 64, 96, 128]

    def blog
      data['tumblelog']
    end

    def name
      blog['name']
    end

    def cname
      blog['cname']
    end

    def host
      "http://" + (cname || "#{name}.tumblr.com")
    end

    def sanitize text, opts={}
      Sanitize.clean text, {}.merge(opts)
    end

    def absolute_url *path_segments
      URI.join(host, *path_segments).to_s
    end

    def local_url url
      URI.parse(url).path
    end

  end
end
