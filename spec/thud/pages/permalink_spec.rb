require 'spec_helper'

describe Thud::Pages::Permalink do

  let(:page) do
    Thud::Pages::Permalink.new @staff, 'infrastructure-update'
  end

  it '#permalink_page?' do
    page.should be_permalink_page
  end

  it '#post_title?' do
    page.post_title?.should == true
  end

end
