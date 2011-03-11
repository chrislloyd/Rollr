module Thud
  class Page

    RSS_PATH = '/rss'
    DUMMY_CUSTOM_CSS = "#rollrdummy {};"

    # The HTML-safe title of your blog.
    tag 'Title' do
      sanitize blog['title']
    end

    # The description of your blog. (may include HTML)
    tag 'Description' do
      blog['description']
    end

    # The HTML-safe description of your blog. (use in META tag)
    tag 'MetaDescription' do
      sanitize tag('Description')
    end

    # RSS feed URL for your blog.
    tag 'RSS' do
      absolute_url RSS_PATH
    end

    # Favicon URL for your blog. Just the smallest portrait.
    tag 'Favicon' do
      tag 'PortraitURL-16'
    end

    # Any custom CSS code added on your 'Customize Theme' screen.
    tag 'CustomCSS' do
      DUMMY_CUSTOM_CSS
    end

    # Portrait photo URL for your blog.
    PORTRAIT_SIZES.each do |n|
      tag "PortraitURL-#{n}" do
        "/default_avatar_#{n}.gif"
      end
    end

  end
end
