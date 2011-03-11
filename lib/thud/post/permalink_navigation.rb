module Thud
  class Post

    # Rendered if there is a 'previous' or 'next' post.
    block 'PermalinkPagination'

    # Rendered if there is a 'previous' post to navigate to.
    block 'PreviousPost'

    # Rendered if there is a 'next' post to navigate to.
    block 'NextPost'

    # URL for the 'previous' (newer) post.
    tag 'PreviousPost'

    # URL for the 'next' (older) post.
    tag 'NextPost'

  end
end
