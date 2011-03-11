require 'spec_helper'

describe Thud::Post::Date do

  let :post do
    Thud::Post.new @staff['posts'].find {|post| post['id'] == '2983461706'}
  end

  let :old do
    Thud::Post.new @staff['posts'].find {|post| post['id'] == '1482002179'}
  end

  it '#date?' do
    post.date?.should == true
  end

  it '#new_day_date?' do
    pending 'access to all posts'
  end

  it '#same_day_date?' do
    pending 'access to all posts'
  end

  it '#day_of_month' do
    post.day_of_month.should == '29'
  end

  it '#day_of_month_with_zero' do
    post.day_of_month_with_zero.should == '29'
    old.day_of_month_with_zero.should == '05'
  end

  it '#day_of_week' do
    post.day_of_week.should == 'Saturday'
    old.day_of_week.should == 'Friday'
  end

  it '#short_day_of_week' do
    post.short_day_of_week.should == 'Sat'
    old.short_day_of_week.should == 'Fri'
  end

  it '#day_of_month_suffix' do
    post.day_of_month_suffix.should == 'th'
    old.day_of_month_suffix.should == 'th'
  end

  it '#day_of_year' do
    post.day_of_year.should == '29'
    old.day_of_year.should == '309'
  end

  it '#week_of_year' do
    pending 'wether Tumblr counts Sunday or Monday as the start of the week'
    # post.week_of_year.should == '...'
    # old.week_of_year.should == '...'
  end

  it '#month' do
    post.month.should == 'January'
    old.month.should == 'November'
  end

  it '#short_month' do
    post.short_month.should == 'Jan'
    old.short_month.should == 'Nov'
  end

  it '#month_number' do
    post.month_number.should == '1'
    old.month_number.should == '11'
  end

  it '#month_number_with_zero' do
    post.month_number_with_zero.should == '01'
    old.month_number_with_zero.should == '11'
  end

  it '#year' do
    post.year.should == '2011'
    old.year.should == '2010'
  end

  it '#short_year' do
    post.short_year.should == '11'
    old.short_year.should == '10'
  end

  it '#am_pm' do
    post.am_pm.should == 'am'
    old.am_pm.should == 'am'
  end

  it '#capital_am_pm' do
    post.capital_am_pm.should == 'AM'
    old.capital_am_pm.should == 'AM'
  end

  it '#_12_hour' do
    post._12_hour.should == '11'
    old._12_hour.should == '8'
  end

  it '#_12_hour_with_zero' do
    post._12_hour_with_zero.should == '11'
    old._12_hour_with_zero.should == '08'
  end

  it '#_24_hour' do
    post._24_hour.should == '11'
    old._24_hour.should == '8'
  end

  it '#_24_hour_with_zero' do
    post._24_hour_with_zero.should == '11'
    old._24_hour_with_zero.should == '08'

  end

  it '#minutes' do
    post.minutes.should == '09'
    old.minutes.should == '19'
  end

  it '#seconds' do
    post.seconds.should == '42'
    old.seconds.should == '33'
  end

  it '#beats' do
    post.beats.should == '000'
    old.beats.should == '000'
  end

  it '#timestamp' do
    post.timestamp.should == '1296259782'
    old.timestamp.should == '1288905573'
  end

  it '#time_ago' do
    pending 'massive investigation of Tumblr"s behaviour'
  end

end
