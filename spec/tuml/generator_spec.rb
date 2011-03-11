require 'spec_helper'

describe Tuml::Generator do

  def render body, data=env, options={}
    Tilt[:tuml].new(options) {body}.render(Object.new, {:data => data})
  end

  let(:env) {double}

  # context 'Static' do
  #
  #   it 'renders static text' do
  #     render('Static Text').should == 'Static Text'
  #   end
  #
  # end
  #
  # context 'Tag' do
  #
  #   it 'asks the current context for the tag' do
  #     env.should_receive(:tag).with('Tag', {}).and_return('Tag')
  #     render('{Tag}').should == 'Tag'
  #   end
  #
  #   it 'passes attributes' do
  #     env.should_receive(:tag).with('Tag', {'foo' => 'bar'}).and_return 'Tag'
  #     render('{Tag foo="bar"}').should == 'Tag'
  #   end
  #
  # end
  #
  # context 'Block' do
  #
  #   it 'gets the block from the current context' do
  #     env.should_receive(:block).with('Block', {}).and_return true
  #     render('{block:Block}Foo{/block:Block}').should == 'Foo'
  #   end
  #
  #   it 'renders the body when the block returns true' do
  #     env.should_receive(:block).with('Foo', {}).and_return true
  #     render('{block:Foo}Foo{/block:Foo}').should == 'Foo'
  #   end
  #
  #   it "doesn't render the body when the block returns false" do
  #     env.should_receive(:block).with('Foo', {}).and_return false
  #     render('{block:Foo}Foo{/block:Foo}').should == ''
  #   end
  #
  #   it "repeatedly renders the body when the block returns a collection" do
  #     env.should_receive(:block).with('Foo', {}).and_return [env, env]
  #     env.should_receive(:tag).with('Bar', {}).twice.and_return 'Bar'
  #     render('{block:Foo}{Bar}{/block:Foo}').should == 'BarBar'
  #   end
  #
  # end
  #
  # context 'Multi' do
  #
  #   it "renders multiple elements" do
  #     env.should_receive(:block).with('Bar', {}).and_return true
  #     env.should_receive(:tag).with('Bar', {}).and_return 'Bar'
  #     render('Foo {block:Bar}{Bar}{/block:Bar} Baz').should == 'Foo Bar Baz'
  #   end
  #
  # end

end
