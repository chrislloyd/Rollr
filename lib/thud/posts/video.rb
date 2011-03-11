module Thud
  module Posts
    class Video < Thud::Post

      HEIGHT_REGEXP = /height="(\d+)"/

      # Rendered for Video posts.
      block 'Video' do
        true
      end

      # Rendered if there is a caption for this post.
      block 'Caption' do
        not tag('Caption').blank?
      end

      # The caption for this post.
      tag 'Caption' do
        post['video-caption']
      end

      tag 'Video-400' do
        post['video-player']
      end

      [500, 250].each do |width|
        tag "Video-#{width}" do
          html = tag('Video-400').dup
          ratio = width/400
          height = html.match(HEIGHT_REGEXP)[1].to_i * ratio

          html.gsub! /width="400"/, "width=\"#{width}\""
          html.gsub! HEIGHT_REGEXP, "height=\"#{height}\""
        end
      end

    end
  end
end
