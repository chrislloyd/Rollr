module Thud
  class Post

    # Rendered if a post was reblogged from another post.
    block 'RebloggedFrom'

    # The username of the blog this post was reblogged from.
    tag 'ReblogParentName'

    # The title of the blog this post was reblogged from.
    tag 'ReblogParentTitle'

    tag 'ReblogParentURL'
    # The URL for the blog this post was reblogged from.

    PORTRAIT_SIZES.each do |n|
      # Portrait photo URL for the blog this post was reblogged from.
      # #{n}-pixels by #{n}-pixels.
      tag "ReblogParentPortraitURL-#{n}"
    end


    # The username of the blog this post was created by.
    tag 'ReblogRootName'

    tag 'ReblogRootTitle'
    # The title of the blog this post was created by.

    tag 'ReblogRootURL'
    # The URL for the blog this post was created by.

    PORTRAIT_SIZES.each do |n|
      # Portrait photo URL for the blog this post was created by. #{n}-pixels
      # by #{n}-pixels.
      tag "ReblogRootPortraitURL-#{n}"
    end

  end
end
