class TemplateContext

  PORTRAIT_SIZES = [16, 24, 30, 40, 46, 64, 96, 128]

  class NotImplemented < StandardError; end

  class << self

    attr_accessor :tags, :blocks

    def inherited subklass
      subklass.tags, subklass.blocks = {}, {}
    end

    def tag name, defaults={}, &code
      self.tags[name.downcase] = code || lambda do
        raise NotImplemented, "{#{name}}"
      end
    end

    def block name, defaults={}, &code
      self.blocks[name.downcase] = code || lambda do
        raise NotImplemented, "{block:#{name}}"
      end
    end

  end

  # include Helpers

  attr_accessor :prototype, :data

  def initialize prototype, data = nil
    self.prototype, self.data = prototype, data || prototype.data
  end


  [:tags, :blocks].each do |type|
    define_method("find_#{type}") do |name|
      self.class.send(type).fetch(name.downcase) do
        if prototype
          prototype.send("find_#{type}", name)
        else
          lambda {|*options| nil}
        end
      end
    end
  end

  def tag name, options=nil
    if options
      instance_exec options, &find_tags(name)
    else
      instance_exec &find_tags(name)
    end
  end

  def block name
    instance_exec &find_blocks(name)
  end

end
