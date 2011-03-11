module Thud
  class Post

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
end
