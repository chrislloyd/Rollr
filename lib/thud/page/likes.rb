module Thud
  class Page

    # Rendered if you are sharing your likes.
    block 'Likes'

    # Standard HTML output of your likes.
    # Standard HTML output of your last 5 likes. Maximum: 10
    # Standard HTML output of your likes with Audio and Video players scaled
    #   to 200-pixels wide. (Scale images with CSS max-width or similar.)
    # Standard HTML output of your likes with text summarize to
    #   100-characters. Maximum: 250
    tag 'Likes' #, :limit => 5, :width => 200, :summarize => 100

  end
end
