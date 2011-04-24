class MainWindow < NSWindow

  WIDTH = 300#px
  HEIGHT = 260#px

  def self.from_top px
    HEIGHT - px
  end

  def drawRect rect
    drawRectOriginal rect

    windowRect = window.frame

    windowRect.origin = NSMakePoint(0, 0)

    cornerRadius = roundedCornerRadius
    NSBezierPath.bezierPathWithRoundedRect(windowRect, xRadius: roundedCornerRadius, yRadius: roundedCornerRadius).addClip

    NSBezierPath.bezierPathWithRect(rect).addClip

    NSColor.blackColor.setFill

    windowRect.fill

  end

end
