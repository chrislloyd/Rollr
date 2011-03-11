require 'spec_helper'

describe Thud::Page::BasicVariables do

  let(:staff) {Thud::Page.new @staff}
  let(:hacker) {Thud::Page.new @hacker}

  it '#title' do
    staff.title.should == 'Tumblr Staff'
  end

  it '#title is HTML-safe' do
    hacker.title.should == 'Tumblr Staff'
  end

  it '#description' do
    staff.description.should == "The <i>official</i> feed from the people behind <a href=\"http://www.tumblr.com/\">Tumblr</a>.\r\n\r\nFollow us for the latest development updates, <a href=\"/tagged/features\">features</a>, <a href=\"/tagged/community\">community</a> <a href=\"/tagged/spotlight\">spotlights</a>, notices, <a href=\"/tagged/events\">events</a>, tips, tutorials, hacks, meetups, themes, antics, philosophy, and trade secrets."
  end

  it '#meta_description is HTML-safe' do
    pending 'investigating how Tumblr adds the elipsis'
    # staff.meta_description.should == 'The official feed from the people behind Tumblr. Follow us for the latest development updates, features, community spotlights, notices, events, tips, tutorials, hacks, meetups, themes, antics,...'
  end

  it '#rss' do
    staff.rss.should == 'http://staff.tumblr.com/rss'
  end

  it '#favicon' do
    staff.favicon.should == 'http://staff.tumblr.com/default_avatar_16.gif'
  end

  it '#custom_css' do
    staff.custom_css.should == staff.class::DUMMY_CUSTOM_CSS
  end

  [16, 24, 30, 40, 48, 64, 96, 128].each do |n|
    it "#portrait_url_#{n}" do
      staff.send("portrait_url_#{n}").should == "http://staff.tumblr.com/default_avatar_#{n}.gif"
    end
  end

end
