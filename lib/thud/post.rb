module Thud
  class Post < Thud::Context

    attr_accessor :collection, :post

    def self.for prototype, post
      case post['type']
        when 'answer'
          Posts::Answer
        when 'audio'
          Posts::Audio
        when 'chat'
          Posts::Chat
        when 'link'
          Posts::Link
        when 'photo'
          Posts::Photo
        when 'quote'
          Posts::Quote
        when 'regular'
          Posts::Text
        when 'video'
          Posts::Video
      end.new self.new(prototype, post), post
    end

    def initialize prototype, post
      super prototype
      self.collection = data['posts']
      self.post = post
    end

  end
end

require 'thud/post/author'
require 'thud/post/basic_variables'
require 'thud/post/date'
require 'thud/post/permalink_navigation'
require 'thud/post/reblogs'
require 'thud/post/tags'
