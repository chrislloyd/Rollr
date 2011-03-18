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


  attr_accessor :prototype
  attr_writer   :data

  def initialize args={}
    self.prototype, self.data = args[:prototype], args[:data]
  end

  def data
    @data || prototype.data
  end

  [:tags, :blocks].each do |type|
    define_method("find_#{type}") do |name|
      # Block passed to fetch is "not-found" case.
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
