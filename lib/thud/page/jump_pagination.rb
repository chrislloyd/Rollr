module Thud
  class Page

    # Rendered for each page greater than the current page minus one-half
    # length up to current page plus one-half length.
    block 'JumpPagination' #, :length => 5

    # Rendered when jump page is the current page.
    block 'CurrentPage'

    # Rendered when jump page is not the current page.
    block 'JumpPage'

    # Page number for jump page.
    tag 'PageNumer'

    # URL for jump page.
    tag 'URL'

  end
end
