require 'spec_helper'

describe Tuml::Filters::ScopeFilter do

  def filter sexp
    Tuml::Filters::ScopeFilter.new.compile! sexp
  end

  it 'does nothing when input is correct' do
    filter(
      [:multi,
        [:sblock, 'Foo'],
        [:sblock, 'Bar'],
        [:static, 'Baz'],
        [:eblock, 'Bar'],
        [:eblock, 'Foo']]).
    should ==
      [:multi,
        [:sblock, 'Foo'],
        [:sblock, 'Bar'],
        [:static, 'Baz'],
        [:eblock, 'Bar'],
        [:eblock, 'Foo']]
  end

  it 'filters out-of-scope closing blocks' do
    filter(
      [:multi,
        [:sblock, 'Foo'],
        [:eblock, 'Bar'],
        [:eblock, 'Foo']]).
    should ==
      [:multi,
        [:sblock, 'Foo'],
        [:eblock, 'Foo']]
  end

  it 'closes unclosed blocks' do
    filter(
      [:multi,
        [:sblock, 'Foo']]).
    should ==
      [:multi,
        [:sblock, 'Foo'],
        [:eblock, 'Foo']]
  end

  it 'filters premature block endings' do
    filter(
      [:multi,
        [:sblock, 'Foo'],
        [:sblock, 'Bar'],
        [:eblock, 'Foo']]).
    should ==
      [:multi,
        [:sblock, 'Foo'],
        [:sblock, 'Bar'],
        [:eblock, 'Bar'],
        [:eblock, 'Foo']]
  end

  it 'treats the second open block as a closing block' do
    filter(
      [:multi,
        [:sblock, 'Foo'],
        [:static, 'Bar'],
        [:sblock, 'Foo']]).
    should ==
      [:multi,
        [:sblock, 'Foo'],
        [:static, 'Bar'],
        [:eblock, 'Foo']]
  end

  it 'filters premature block endings with implicit block endings' do
    filter(
      [:multi,
        [:sblock, 'Foo'],
        [:sblock, 'Bar'],
        [:sblock, 'Foo']]).
    should ==
      [:multi,
        [:sblock, 'Foo'],
        [:sblock, 'Bar'],
        [:sblock, 'Foo'],
        [:eblock, 'Foo'],
        [:eblock, 'Bar'],
        [:eblock, 'Foo']]
  end


end
