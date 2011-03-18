class Post < TemplateContext

  attr_accessor :collection, :post

  def self.for args={}
    base = self.new args
    case base.post['type']
      when 'answer'
        AnswerPost
      when 'audio'
        AudioPost
      when 'chat'
        ChatPost
      when 'link'
        LinkPost
      when 'photo'
        PhotoPost
      when 'quote'
        QuotePost
      when 'regular'
        TextPost
      when 'video'
        VideoPost
    end.new args.merge(prototype: base)
  end

  def initialize args={}
    super
    self.post = args[:post]
  end

  def collection
    data['posts']
  end

  ## Basic Variables

  # The permalink for a post.
  tag 'Permalink' do
    # TODO local_url
    post['url']
  end

  # A shorter URL that redirects to this post. For example:
  # http://tumblr.com/xpv5qtavm
  tag 'ShortURL' do
    'http://tumblr.com/xpv5qtavm'
  end

  # The numeric ID for a post.
  tag 'PostID' do
    post['id']
  end

  # An HTML class-attribute friendly list of the post's tags. (Example:
  # "humor office new_york_city") By default, an HTML friendly version of
  # the source domain of imported posts will be included. (Example:
  # "twitter_com", "digg_com", etc.) This may not behave as expected with
  # feeds like Del.icio.us that send their content URLs as their permalinks.
  # The class-attribute "reblog" will be included automatically if the post
  # was reblogged from another post.
  tag 'TagsAsClasses'

  # Only rendered for the post at the specified offset. This makes it
  # possible to insert an advertisement or design element in the middle of
  # your posts.
  (1..15).each do |n|
    block "Post#{n}" do
      posts['posts'].index(data) == n
    end
  end

  # Rendered for every one of the current pages odd-numbered posts.
  block 'Odd'

  # Rendered for every one of the current pages even-numbered posts.
  block 'Even'

  # Rendered on index pages for posts with Read More breaks.
  block 'More'

  # URL to an HTML partial of this post's Notes. Useful for loading Notes via AJAX.
  tag 'PostNotesURL'


  ## Date

  # Rendered for all posts. Always wrap dates in this block so they will be properly hidden on non-post pages.
  block 'Date' do
    true
  end

  # TODO Yeah, I know this is wrong...
  # Rendered for posts that are the first to be listed for a given day.
  block 'NewDayDate' do
    true
  end

  # TODO Yeah, I know this is wrong...
  # Rendered for subsequent posts listed for a given day.
  block 'SameDayDate' do
    true
  end

  # The day of the month. Returns '1' to '31'.
  tag 'DayOfMonth' do
    time.day.to_s
  end

  # The day of the month with zero padding.
  tag 'DayOfMonthWithZero' do
    '%02d' % time.day
  end

  # The day of the week. Returns 'Monday' through 'Sunday'.
  tag 'DayOfWeek' do
    time.strftime('%A')
  end

  # The abbreviated day of the week. Returns 'Mon' through 'Sun'.
  tag 'ShortDayOfWeek' do
    time.strftime('%a')
  end

  # The day of the week number. Returns '1' through '7'.
  tag 'DayOfWeekNumber' do
    time.wday.to_s
  end

  # The day of the month suffix. Returns 'st', 'nd', 'rd', 'th'.
  tag 'DayOfMonthSuffix' do
    ordinal(time.day)
  end

  # The day of the year. Returns '1' through '365'.
  tag 'DayOfYear' do
    time.yday.to_s
  end

  # The week of the year. Returns '1' through '52'
  tag 'WeekOfYear' do
    time.wday.to_s
  end

  # The month of the year. Returns 'January' through 'December'.
  tag 'Month' do
    time.strftime('%B')
  end

  # The abbreviated month of the year. Returns 'Jan' through 'Dec'.
  tag 'ShortMonth' do
    time.strftime('%b')
  end

  # The month number. Returns '1' through '12'.
  tag 'MonthNumber' do
    time.month.to_s
  end

  # The month number with zero padding. Returns '01' through '12'.
  tag 'MonthNumberWithZero' do
    '%02d' % time.month
  end

  # The year.
  tag 'Year' do
    time.year.to_s
  end

  # The least two significant digits of the year.
  tag 'ShortYear' do
    time.strftime('%y')
  end

  # The meridian indicator. Returns 'am' or 'pm'.
  tag 'AmPm' do
    time.strftime('%P')
  end

  # The capitalised meridian indicator. Returns 'AM' or 'PM'.
  tag 'CapitalAmPm' do
    time.strftime('%p')
  end

  # The hour in 12 hour format. Returns '0' through '12'.
  tag '12Hour' do
    time.strftime('%l').strip
  end

  # The hour in 24 hour format. Returns '0' through '23'.
  tag '24Hour' do
    time.strftime('%k').strip
  end

  # The hour in 12 hour format with zero padding. Returns '00' through '12'.
  tag '12HourWithZero' do
    time.strftime('%I')
  end

  # The hour in 24 hour format with zero padding. Returns '00' through '23'.
  tag '24HourWithZero' do
    time.strftime('%H')
  end

  # The number of minutes zero padded. Returns '00' through '59'.
  tag 'Minutes' do
    '%02d' % time.min
  end

  # The number of seconds zero padded. Returns '00' through '59'.
  tag 'Seconds' do
    '%02d' % time.sec
  end

  # The number of beats in the second. Note, Tumblr only provides
  # timestamps with a resolution of 1s so the beats will always be '000'.
  tag 'Beats' do
    time.strftime('%L')
  end

  # The unix timestamp.
  tag 'Timestamp' do
    data['unix-timestamp'].to_s
  end

  # A human-readable contextual time. Returns '1 minute ago', '2 hours ago', '3 weeks ago', etc.
  tag 'TimeAgo'


  ## Permalink Pagination

  # Rendered if there is a 'previous' or 'next' post.
  block 'PermalinkPagination'

  # Rendered if there is a 'previous' post to navigate to.
  block 'PreviousPost'

  # Rendered if there is a 'next' post to navigate to.
  block 'NextPost'

  # URL for the 'previous' (newer) post.
  tag 'PreviousPost'

  # URL for the 'next' (older) post.
  tag 'NextPost'


  ## Reblogs

  # Rendered if a post was reblogged from another post.
  block 'RebloggedFrom'

  # The username of the blog this post was reblogged from.
  tag 'ReblogParentName'

  # The title of the blog this post was reblogged from.
  tag 'ReblogParentTitle'

  tag 'ReblogParentURL'
  # The URL for the blog this post was reblogged from.

  PORTRAIT_SIZES.each do |n|
    # Portrait photo URL for the blog this post was reblogged from.
    # #{n}-pixels by #{n}-pixels.
    tag "ReblogParentPortraitURL-#{n}"
  end


  # The username of the blog this post was created by.
  tag 'ReblogRootName'

  tag 'ReblogRootTitle'
  # The title of the blog this post was created by.

  tag 'ReblogRootURL'
  # The URL for the blog this post was created by.

  PORTRAIT_SIZES.each do |n|
    # Portrait photo URL for the blog this post was created by. #{n}-pixels
    # by #{n}-pixels.
    tag "ReblogRootPortraitURL-#{n}"
  end


  ## Tags

  # Rendered inside {block:Posts} if post has tags.
  block 'HasTags' do
    not call('Tags').empty?
  end

  # Rendered for each of a post's tags.
  block 'Tags' do
    data['tags'].map {|name| Tag.new(self, name)}
  end

  class Tag < TemplateContext

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


private

  def time
    @time ||= Time.at post['unix-timestamp']
  end

  # Stolen from the ActiveSupport::Inflector
  # lib/active_support/inflector.rb#295
  def ordinal number
    if (11..13).include?(number.to_i % 100)
      'th'
    else
      case number.to_i % 10
        when 1; 'st'
        when 2; 'nd'
        when 3; 'rd'
        else    'th'
      end
    end
  end

end
