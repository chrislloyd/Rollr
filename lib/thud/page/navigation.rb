module Thud
  class Page

    # Rendered if there is a 'previous' or 'next' page.
    block 'Pagination' do
      false
    end

    # Rendered if there is a 'previous' page (newer posts) to navigate to.
    block 'PreviousPage' do
      page > 1
    end

    # Rendered if there is a 'next' page (older posts) to navigate to.
    block 'NextPage' do
      # page < (20 - 6)
    end

    # URL for the 'previous' page (newer posts).
    tag 'PreviousPage'

    # URL for the 'next' page (older posts).
    tag 'NextPage'

    # Current page number.
    tag 'CurrentPage'

    tag 'TotalPages'
    # Total page count.

    # Rendered if Submissions are enabled.
    block 'SubmissionsEnabled' do
      false
    end

    # The customizable label for the Submit link. (Example: 'Submit')
    tag 'SubmitLabel'

    # Rendered if asking questions is enabled.
    block 'AskEnabled' do
      false
    end

    # The customizable label for the Ask link. (Example: 'Ask me anything')
    tag 'AskLabel'

  end
end
