module Thud
  module Posts
    class Answer < Thud::Post

      # Rendered for Answer posts.
      block 'Answer' do
        true
      end

      # The question for this post. (May contain heavily filtered HTML).
      tag 'Question'

      # The answer for this post. (May contain HTML)
      tag 'Answer'

      # Simple HTML text link with the asker's username and URL, or the plain
      # text string "Anonymous".
      tag 'Asker'

      # Portrait photo URL for the asker.
      PORTRAIT_SIZES.each do |n|
        tag "AskerPortraitURL-#{n}"
      end

    end
  end
end
