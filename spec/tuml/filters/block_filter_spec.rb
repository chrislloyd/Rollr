require 'spec_helper'

describe Tuml::Filters::BlockFilter do

  def transform sexp
    Tuml::Filters::BlockFilter.new.compile! sexp
  end

  it 'transforms simple blocks' do
    transform(
      [:multi,
        [:sblock, 'Foo'],
        [:eblock, 'Foo']]).
    should ==
      [:multi,
        [:block, 'Foo', [:multi]]]

  end

  it 'transforms block contents' do
    transform(
      [:multi,
        [:static, 'Foo'],
        [:sblock, 'Foo'],
        [:static, 'Foo'],
        [:eblock, 'Foo']]).
    should ==
      [:multi,
        [:static, 'Foo'],
        [:block, 'Foo', [:multi,
            [:static, 'Foo']]]]
  end

  it 'transforms nested blocks' do
    transform(
      [:multi,
        [:sblock, 'Foo'],
        [:sblock, 'Bar'],
        [:eblock, 'Bar'],
        [:eblock, 'Foo']]).
    should ==
      [:multi,
        [:block, 'Foo',
          [:multi,
            [:block, 'Bar', [:multi]]]]]
  end

end
