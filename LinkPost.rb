class LinkPost < Post

  # Rendered for Link posts.
  block 'Link' do
    true
  end

  # The URL of this post.
  tag 'URL' do
    post['link-url']
  end

  # The name of this post. Defaults to the URL if no name is entered.
  tag 'Name' do
    post['link-text'] || tag('URL')
  end

  # TODO: Create option to set
  # Should be included inside the A-tags of Link posts. Returns
  # target="_blank" if you've enabled "Open links in new window".
  tag 'Target' do
    'target="_blank"'
  end

  # Rendered if there is a description for this post.
  block 'Description' do
    not tag('Description').blank?
  end

  # The description for this post.
  tag 'Description' do
    post['link-description']
  end

end
