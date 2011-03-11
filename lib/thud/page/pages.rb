module Thud
  class Page

    class CustomPage < Thud::Context

      def initialize prototype, data
        super prototype, data
      end

      # The URL for this page.
      tag 'URL' do
        data['url']
      end

      # The label for this page.
      tag 'Label' do
        data['label']
      end
    end

    # Rendered if you have defined any custom pages.
    block 'HasPages' do
      not block('Pages').empty?
    end

    # Rendered for each custom page.
    block 'Pages' do
      data['pages'].map {|page| Thud::Page::CustomPage.new self, page}
    end

  end
end