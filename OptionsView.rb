class OptionsView < NSView

  def initWithFrame *args
    super.tap do |val|
      addSubview site_field
    end
  end

  def site_field
    @site_field ||= NSTextField.alloc.instance_eval do

      def textDidEndEditing notification
        trigger 'Changed'
      end

      self
    end.initWithFrame([22*0.5, 22, MainWindow::WIDTH - 22, 22]).tap {|tf|
        tf.editable = tf.selectable = true
        tf.acceptsFirstResponder = false
        tf.cell.placeholderString = 'chrislloyd.tumblr.com'
      }
  end

end
