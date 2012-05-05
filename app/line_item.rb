class LineItem

  def initialize(startPoint, color, bold)
    @startPoint = startPoint
    @points =[]
    @color = color
    @bold = bold
  end

  # TODO カクカクするのでスプライン補完などが必要
  def draw(context)
    return if @points.length == 0
    
    CGContextSetLineWidth(context, @bold)
    CGContextSetStrokeColorWithColor(context, @color)
    #CGContextSetLineCap(context, kCGLineCapRound)  #エラーになる?

    CGContextMoveToPoint(context, @startPoint.x, @startPoint.y)
    @points.each do |point|
      CGContextAddLineToPoint(context, point.x, point.y)
    end
    
    CGContextStrokePath(context)
  end
  
  def draw_begin(point)
    @startPoint = point
  end

  def draw_move(point)
    @points.push(point)
  end

  def draw_end
  end  
  
end
