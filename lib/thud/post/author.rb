module Thud
  class Post

    # The username of the author of a post to an additional group blog.
    tag 'PostAuthorName'

    # The title of the author's blog for a post to an additional group blog.
    tag 'PostAuthorTitle'

    # The blog URL for the author of a post to an additional group blog.
    tag 'PostAuthorURL'

    # The portrait photo URL for the author of a post to an additional group
    # blog.
    PORTRAIT_SIZES.each do |n|
      tag "PostAuthorPortraitURL-#{n}"
    end

  end
end
