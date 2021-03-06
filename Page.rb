class Page < TemplateContext

  RSS_PATH = '/rss'
  DUMMY_CUSTOM_CSS = "#rollrdummy {};"


  ## Basic Variables

  # The HTML-safe title of your blog.
  tag 'Title' do
    sanitize blog['title']
  end

  # The description of your blog. (may include HTML)
  tag 'Description' do
    blog['description']
  end

  # The HTML-safe description of your blog. (use in META tag)
  tag 'MetaDescription' do
    sanitize tag('Description')
  end

  # RSS feed URL for your blog.
  tag 'RSS' do
    absolute_url RSS_PATH
  end

  # Favicon URL for your blog. Just the smallest portrait.
  tag 'Favicon' do
    tag 'PortraitURL-16'
  end

  # Any custom CSS code added on your 'Customize Theme' screen.
  tag 'CustomCSS' do
    DUMMY_CUSTOM_CSS
  end

  # Portrait photo URL for your blog.
  PORTRAIT_SIZES.each do |n|
    tag "PortraitURL-#{n}" do
      "/default_avatar_#{n}.gif"
    end
  end


  ## Following

  # Rendered if you're following other blogs.
  block 'Following' do
    false
  end

  class Following < TemplateContext
    # The username of the blog you're following.
    tag 'FollowedName'

    # The title of the blog you're following.
    tag 'FollowedTitle'

    # The URL for the blog you're following.
    tag 'FollowedURL'

    # Portrait photo URL for the blog you're following.
    PORTRAIT_SIZES.each do |n|
      tag "FollowedPortraitURL-#{n}"
    end
  end

  # Rendered for each blog you're following.
  block 'Followed' do
    []
  end


  ## Group Blogs

  # Rendered on additional public group blogs.
  block 'GroupMembers'

  class GroupMember < TemplateContext
    # The username of the member's blog.
    tag 'GroupMemberName'

    # The title of the member's blog.
    tag 'GroupMemberTitle'

    # The URL for the member's blog.
    tag 'GroupMemberURL'

    # Portrait photo URL for the member.
    PORTRAIT_SIZES.each do |n|
      tag "GroupMemberPortraitURL-#{n}"
    end
  end

  # Rendered for each additional public group blog member.
  block 'GroupMember' do
    []
  end


  ## Likes

  # Rendered if you are sharing your likes.
  block 'Likes'

  # Standard HTML output of your likes.
  # Standard HTML output of your last 5 likes. Maximum: 10
  # Standard HTML output of your likes with Audio and Video players scaled
  #   to 200-pixels wide. (Scale images with CSS max-width or similar.)
  # Standard HTML output of your likes with text summarize to
  #   100-characters. Maximum: 250
  tag 'Likes' #, :limit => 5, :width => 200, :summarize => 100


  ## Navigation

  # Rendered if there is a 'previous' or 'next' page.
  block 'Pagination' do
    false
  end

  # Rendered if there is a 'previous' page (newer posts) to navigate to.
  block 'PreviousPage' do
    page_number > 1
  end

  # Rendered if there is a 'next' page (older posts) to navigate to.
  block 'NextPage'
  # page < (20 - 6)


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
    true
  end

  # The customizable label for the Submit link. (Example: 'Submit')
  tag 'SubmitLabel' do
    'Submit'
  end

  # Rendered if asking questions is enabled.
  block 'AskEnabled' do
    true
  end

  # The customizable label for the Ask link. (Example: 'Ask me anything')
  tag 'AskLabel' do
    'Ask me anything'
  end


  ## Custom Pages

  class CustomPage < TemplateContext
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
    # data['pages'].map {|page| CustomPage.new prototype: self, data: page}
    []
  end


  ## Twitter

  # Rendered if you have Twitter integration enabled.
  tag 'Twitter'

  # Your Twitter username.
  tag 'TwitterUsername' do
    'rollrapp'
  end


private

  def blog
    data['tumblelog']
  end

  def name
    blog['name']
  end

  def cname
    blog['cname']
  end

  def host
    "http://" + (cname || "#{name}.tumblr.com")
  end

  def sanitize text, opts={}
    Sanitize.clean text, opts
  end

  def absolute_url *path_segments
    URI.join(host, *path_segments).to_s
  end

  def local_url url
    URI.parse(url).path
  end

end
