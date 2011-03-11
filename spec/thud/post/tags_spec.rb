require 'spec_helper'

describe Thud::Post::Tags do

  let :tagsmcgee do
    Thud::Post.new @dearcoketalk['posts'].find {|post| post['id'] == '2951542114'}
  end

  let :mrnotags do
    Thud::Post.new @merlin['posts'].find {|post| post['id'] == '3041854362'}
  end

  it '#has_tags?' do
    tagsmcgee.has_tags?.should be_true
    mrnotags.has_tags?.should be_false
  end

  it '#tags' do
    tagsmcgee.should have_tags
    tagsmcgee.tags.length.should == 1
    tagsmcgee.tags.each {|tag| tag.should be_a(Thud::Post::Tag)}

    mrnotags.should_not have_tags
  end

  describe Thud::Post::Tag do

    it '#tag' do
      tagsmcgee.tags.first.tag.should == 'fun-sized'
    end

    it '#url_safe_tag' do
      pending 'finding out what constitutes as "URL safe"'
    end

    it '#tag_url' do
      pending 'finding out what the tag url is'
    end

    it '#tag_url_chrono' do
      pending 'finding out what the hell chrono means'
    end

  end

end
