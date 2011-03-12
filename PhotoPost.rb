class PhotoPost < Post

  # Rendered for Photo posts.
  block 'Photo' do
    true
  end

  # The HTML-safe version of the caption (if one exists) of this post.
  tag 'PhotoAlt' do
    post['photo-alt']
  end

  # Rendered if there is a caption for this post.
  block 'Caption' do |asfd|
    post['photo-caption']
  end

  # The caption for this post.
  tag 'Caption' do
    post['photo-caption']
  end

  # A click-through URL for this photo if set.
  tag 'LinkURL' do
    post['photo-link-url']
  end

  # An HTML open anchor-tag including the click-through URL if set.
  tag 'LinkOpenTag' do
    "<a" + if url = tag('LinkURL')
      " href='#{url}'>"
    else
      '>'
    end
  end

  # A closing anchor-tag output only if a click-through URL is set.
  tag 'LinkCloseTag' do
    '</a>'
  end

  # URL for the photo of this post.
  [500, 400, 250, 100, '75sq'].each do |n|
    tag "PhotoURL-#{n}" do
      post["photo-url-#{n}"]
    end
  end

  # Rendered if there is a high-res photo for this post.
  block 'HighRes' do
    not tag('PhotoURL-HighRes').blank?
  end

  # URL for the high-res photo of this post. Rendered if there is high-res
  # photo for this post.
  tag 'PhotoURL-HighRes' do
    post['photo-url-1280']
  end

  # Embed-code for the photoset.
  [500, 400, 250].each do |n|
    tag "Photoset-#{n}"
  end

end
