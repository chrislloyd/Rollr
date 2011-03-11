require 'spec_helper'

describe Thud::Pages::Index do

  let :page do
    Thud::Pages::Index.new(@staff)
  end

  it '#index_page?' do
    page.should be_index_page
  end

end
