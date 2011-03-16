class DropView < NSBox
  attr_accessor :path_url
  attr_writer :icon

  FILL_COLOR = NSColor.whiteColor
  STROKE_COLOR = NSColor.colorWithCalibratedRed 0.425, green:0.425, blue:0.425, alpha:1.000

  FOCUS_FILL_COLOR = NSColor.colorWithCalibratedRed 0.663, green:0.788, blue:1.000, alpha:1.000
  FOCUS_STROKE_COLOR = NSColor.whiteColor

  attr_reader :icon

  # TODO: NSFilenamesPboardType is a hack, it accepts any type of file. It
  #       should only accept .tuml files.
  def initWithFrame *args
    super

    self.boxType = NSBoxCustom
    self.borderType = NSNoBorder
    self.fillColor = FILL_COLOR

    contentView.addSubview arrow_view
    contentView.addSubview text

    # registerForDraggedTypes ['com.tumblr.tuml']
    registerForDraggedTypes [NSFilenamesPboardType]
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
    trigger 'Changed'
  end

  def show_file path
    arrow_view.hidden = true

    @icon = NSWorkspace.sharedWorkspace.iconForFile(path).tap {|i|
        i.size = NSSize.new(80.0, 80.0)
      }

    text.string = File.basename path
    contentView.needsDisplay = true
  end

  def drawRect rect
    super

    if arrow_view.hidden?
      icon.drawInRect arrow_view.frame, fromRect: NSZeroRect, operation: NSCompositeSourceAtop, fraction: 1.0
    end
  end

private

  def focus!
    self.fillColor = FOCUS_FILL_COLOR
    text.textColor = FOCUS_STROKE_COLOR
    arrow_view.focus!
  end

  def blur!
    self.fillColor = FILL_COLOR
    text.textColor = STROKE_COLOR
    arrow_view.blur!
  end

  def arrow_view
    @arrow_view ||= ArrowView.alloc.initWithFrame([110, (22 - 5) + 12 + 12, 80, 80])
  end

  def text
    @text ||= NSTextView.alloc.initWithFrame([0, 22 - 5, 300, 12]).tap {|text|
        text.insertText 'Drop template here'
        text.editable = false
        text.selectable = false

        text.textColor = STROKE_COLOR
        text.drawsBackground = false

        text.setAlignment NSCenterTextAlignment, range: NSRange.new(0,text.textStorage.length)
      }
  end

end
