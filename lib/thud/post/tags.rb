module Thud
  class Post

    # Rendered inside {block:Posts} if post has tags.
    block 'HasTags' do
      not call('Tags').empty?
    end

    # Rendered for each of a post's tags.
    block 'Tags' do
      data['tags'].map {|name| Tag.new(self, name)}
    end

    class Tag < Thud::Context

      attr_accessor :name

      def initialize parent, name
        self.parent, self.name = parent, name
      end

      # The name of this tag.
      tag 'Tag' do
        name
      end

      # A URL safe version of this tag.
      tag 'URLSafeTag'

      # The tag page URL with other posts that share this tag.
      tag 'TagURL'

      # The tag page URL with other posts that share this tag in chronological
      # order.
      tag 'TagURLChrono'

    end

  end
end
