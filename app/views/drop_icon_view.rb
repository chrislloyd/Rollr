class DropIconView < NSView
  attr_accessor :outline_rect

  OUTLINE = 2#px
  OUTLINE_RADIUS = 16#px

  TUMBLR_BLUE = NSColor.colorWithCalibratedRed(0.138, green:0.211, blue:0.320, alpha: 1.0)

  attr_accessor :focus_color, :default_color

  def awakeFromNib
    self.outline_rect = NSMakeRect 0 + OUTLINE/2,
                                   0 + OUTLINE/2,
                                   frame.size.width - OUTLINE,
                                   frame.size.height - OUTLINE
  end

  def drawRect rect
    (@focus ? focus_color : default_color).setStroke

    ## Outline
    outline = NSBezierPath.bezierPathWithRoundedRect outline_rect,
                                            xRadius: OUTLINE_RADIUS,
                                            yRadius: OUTLINE_RADIUS

    outline.lineWidth = OUTLINE
    outline.stroke

    ## Arrow

    mid_x = frame.size.width*0.5
    mid_y = frame.size.height*0.5

    # Body
    bw = 10
    bh = 25.5
    # Head
    hw = 20
    hh = 20

    # Total
    tw = bw + hw
    th = bh + hh

    arrow = NSBezierPath.bezierPath
    arrow.moveToPoint NSPoint.new(mid_x - bw, mid_y + (th*0.5))

    [
      [mid_x - bw, mid_y - (th*0.5) + hh],
      [mid_x - hw, mid_y - (th*0.5) + hh],
      [mid_x, mid_y - (th*0.5)],
      [mid_x + hw, mid_y - (th*0.5) + hh],
      [mid_x + bw, mid_y - (th*0.5) + hh],
      [mid_x + bw, mid_y + (th*0.5)]
    ].each do |(x, y)|
      arrow.lineToPoint NSPoint.new(x, y)
    end

    arrow.closePath

    arrow.lineWidth = OUTLINE
    arrow.lineJoinStyle = NSRoundLineJoinStyle
    arrow.stroke
  end

  def focus!
    @focus = true
    self.needsDisplay = true
  end

  def blur!
    @focus = false
    self.needsDisplay = true
  end

end
