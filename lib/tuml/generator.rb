module Tuml
  class Generator < Temple::Generator

    default_options[:stack] = '_s'
    default_options[:tmp] = '_tmp'
    default_options[:page] = 'page'

    def preamble
      "#{buffer} = [] ; _s = [#{options[:page]}]"
    end

    def postamble
      "#{buffer}.join"
    end

    def on_static text
      concat text.inspect
    end

    def on_tag name
      concat tag(name)
    end

    # TODO: Actually implement
    def on_ttag type, name
      concat tag(name)
    end

    def on_color name
      concat '#FFF'.inspect
    end

    def on_font name
      concat 'Helvetica'.inspect
    end

    def on_image name
      concat '/foo.png'.inspect
    end

    def on_text name
      concat 'Foo'.inspect
    end

    def on_lang name
      concat name.inspect
    end

    def on_block name, body
      compiled_body = compile! body

      compact <<-BLOCK
        if #{tmp} = #{block name}
          if #{tmp}.respond_to?(:each)
            #{tmp}.each do |_item|
              #{stack} << _item
              #{compiled_body}
              #{stack}.pop
            end
          else
            #{compiled_body}
          end
        end
      BLOCK
    end

  private

    def stack
      options[:stack]
    end

    def tmp
      options[:tmp]
    end

    def context
      "#{stack}.last"
    end

    def tag name, attrs=nil
      "#{context}.tag(#{name.inspect}, #{attrs.inspect})"
    end

    def block name
      "#{context}.block(#{name.inspect})"
    end

    # Cleans up the resulting template so everything fits nicely on one line.
    def compact text
      text.split("\n").map {|line| line.strip}.join(' ; ')
    end

  end
end
