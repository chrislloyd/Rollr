module Thud
  module Posts
    class Text < Thud::Post

      # Rendered for Text posts.
      block 'Text' do
        true
      end

      # Rendered if there is a title for this post.
      block 'Title' do
        not tag('Title').blank?
      end

      # The title of this post.
      tag 'Title' do
        post['regular-title']
      end

      # The content of this post.
      tag 'Body' do
        post['regular-body']
      end

    end
  end
end
