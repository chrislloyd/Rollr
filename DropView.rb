class DropView < NSBox
  attr_accessor :path_url
  attr_writer :icon

  FOCUS_FILL_COLOR = NSColor.colorWithCalibratedRed 0.663, green:0.788, blue:1.000, alpha:1.000

  GRAY_COLOR = NSColor.colorWithCalibratedRed 0.425, green:0.425, blue:0.425, alpha:1.000

  # TODO: NSFilenamesPboardType is a hack, it accepts any type of file. It
  #       should only accept .tuml files.
  def awakeFromNib
    registerForDraggedTypes [NSFilenamesPboardType]

    icon.focus_color = NSColor.whiteColor
    icon.default_color = GRAY_COLOR
  end

  def draggingEntered sender
    return NSDragOperationNone if sender.draggingSource == self

    focus!
    NSDragOperationCopy
  end

  def draggingExited sender
    blur!
  end

  def prepareForDragOperation sender
    true
  end

  def performDragOperation sender
    self.path_url = sender.draggingPasteboard.pasteboardItems.first.stringForType 'public.file-url'
    true
  end

  def concludeDragOperation sender
    blur!
    trigger 'DropViewConcludedDrag'
  end

  def show_file path
    icon.hidden = true
    image_view.image = NSWorkspace.sharedWorkspace.iconForFile(path).tap {|i|
          i.size = NSSize.new(80.0, 80.0)
        }
    image_view.hidden = false

    text.stringValue = File.basename path
    contentView.needsDisplay = true
  end

private

  def focus!
    self.fillColor = FOCUS_FILL_COLOR
    text.textColor = NSColor.whiteColor
    icon.focus!
  end

  def blur!
    self.fillColor = NSColor.whiteColor
    text.textColor = GRAY_COLOR
    icon.blur!
  end

  def icon
    @icon ||= contentView.subviews.find {|view| view.is_a? ArrowIconView}
  end

  def image_view
    @image ||= contentView.subviews.find {|view| view.is_a? NSImageView}
  end

  def text
    @text ||= contentView.subviews.find {|view| view.is_a? NSTextField}
  end

end
