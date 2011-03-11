require 'spec_helper'

describe Tuml::LangParser do

  def parse input
    Tuml::LangParser.new.parse(input).sexp
  end

  context 'Multi' do

    it 'parses an empty string' do
      parse('').should ==
      [:multi]
    end

    it 'parses multiple elements' do
      parse('string{Tag}{block:Block}{/block:Block}').should ==
      [:multi,
        [:static, 'string'],
        [:tag, 'Tag'],
        [:sblock, 'Block'],
        [:eblock, 'Block']]
    end

  end


  context 'Static' do

    it 'parses static text' do
      parse('Hello World!').should ==
      [:multi,
        [:static, 'Hello World!']]
    end

    it 'parses incomplete tags' do
      parse('{Foo').should ==
      [:multi,
        [:static, '{Foo']]
    end

  end


  context 'Tag' do

    it 'parses variables' do
      parse('{Foo}').should ==
      [:multi,
        [:tag, 'Foo']]
    end

    it 'parses variables surrounded by text' do
      parse('a {Foo} b').should ==
      [:multi,
        [:static, 'a '],
        [:tag, 'Foo'],
        [:static, ' b']]
    end

    it 'parses multiple instances of the same tag' do
      parse('{Foo} + {Foo}').should ==
      [:multi,
        [:tag, 'Foo'],
        [:static, ' + '],
        [:tag, 'Foo']]
    end

    it 'parses multiple different tags' do
      parse('{Foo} + {Bar}').should ==
      [:multi,
        [:tag, 'Foo'],
        [:static, ' + '],
        [:tag, 'Bar']]
    end

    it 'parses attributes' do
      parse('{Foo bar="bar"}').should ==
      [:multi,
        [:tag, 'Foo', {'bar' => 'bar'}]]
    end

    it 'parses attributes with single quotes' do
      parse('{Foo bar=\'bar\'}').should ==
      [:multi,
        [:tag, 'Foo', {'bar' => 'bar'}]]
    end

    it 'parses multiple attributes' do
      parse('{Foo bar="bar" baz="baz"}').should ==
      [:multi,
        [:tag, 'Foo', {'bar' => 'bar', 'baz' => 'baz'}]]
    end

  end


  context 'Escaped Tags' do

    ['Plaintext', 'JS', 'JSPlaintext', 'URLEncoded'].each do |type|

      it "parses #{type}" do
        parse("{#{type}Foo}").should ==
        [:multi,
          [:ttag, type.downcase.to_sym, 'Foo']]
      end

    end

  end


  context 'Block' do

    it 'parses empty blocks' do
      parse('{block:Foo}{/block:Foo}').should ==
      [:multi,
        [:sblock, 'Foo'],
        [:eblock, 'Foo']]
    end

    it 'parses blocks with static content' do
      parse('{block:Foo}Bar{/block:Foo}').should ==
      [:multi,
        [:sblock, 'Foo'],
        [:static, 'Bar'],
        [:eblock, 'Foo']]
    end

    it 'parses blocks with tag content' do
      parse('{block:Foo}{Tag}{/block:Foo}').should ==
      [:multi,
        [:sblock, 'Foo'],
        [:tag, 'Tag'],
        [:eblock, 'Foo']]
    end

    it 'parses nested blocks' do
      parse('{block:Foo}{block:Bar}{/block:Bar}{/block:Foo}').should ==
      [:multi,
        [:sblock, 'Foo'],
        [:sblock, 'Bar'],
        [:eblock, 'Bar'],
        [:eblock, 'Foo']]
    end

    it "parses lone open blocks" do
      parse('{block:Foo}').should ==
      [:multi,
        [:sblock, 'Foo']]
    end

    it "parses mismatched blocks" do
      parse('{/block:Foo}').should ==
      [:multi,
        [:eblock, 'Foo']]
    end

    it "parses around mismatched blocks" do
      parse('Foo {/block:Foo} Bar').should ==
      [:multi,
        [:static, 'Foo '],
        [:eblock, 'Foo'],
        [:static, ' Bar']]
    end

    it "parses unusual block pairs" do
      parse('{block:Foo}{block:Bar}{/block:Foo}{/block:Bar}').should ==
      [:multi,
        [:sblock, 'Foo'],
        [:sblock, 'Bar'],
        [:eblock, 'Foo'],
        [:eblock, 'Bar']]
    end

  end

  context "Custom variables" do

    [:color, :font, :image, :lang, :text].each do |type|
      it "parses #{type} tags" do
        parse("{#{type}:Foo}").should ==
        [:multi,
          [type, 'Foo']]
      end

      it "parses #{type} tags with long names" do
        parse("{#{type}:Foo Bar Baz}").should ==
        [:multi,
          [type, 'Foo Bar Baz']]
      end
    end

  end

end
