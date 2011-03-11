module Thud
  class Post

    # The permalink for a post.
    tag 'Permalink' do
      local_url post['url']
    end

    # A shorter URL that redirects to this post. For example:
    # http://tumblr.com/xpv5qtavm
    tag 'ShortURL' do
      'http://tumblr.com/xpv5qtavm'
    end

    # The numeric ID for a post.
    tag 'PostID' do
      post['id']
    end

    # An HTML class-attribute friendly list of the post's tags. (Example:
    # "humor office new_york_city") By default, an HTML friendly version of
    # the source domain of imported posts will be included. (Example:
    # "twitter_com", "digg_com", etc.) This may not behave as expected with
    # feeds like Del.icio.us that send their content URLs as their permalinks.
    # The class-attribute "reblog" will be included automatically if the post
    # was reblogged from another post.
    tag 'TagsAsClasses'

    # Only rendered for the post at the specified offset. This makes it
    # possible to insert an advertisement or design element in the middle of
    # your posts.
    (1..15).each do |n|
      block "Post#{n}" do
        posts['posts'].index(data) == n
      end
    end

    # Rendered for every one of the current pages odd-numbered posts.
    block 'Odd'

    # Rendered for every one of the current pages even-numbered posts.
    block 'Even'

    # Rendered on index pages for posts with Read More breaks.
    block 'More'

    # URL to an HTML partial of this post's Notes. Useful for loading Notes via AJAX.
    tag 'PostNotesURL'

  end
end
