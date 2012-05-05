class DrawBoardView < UIView
  attr_accessor :drawItemManager
  
  def drawRect(rect)
    context = UIGraphicsGetCurrentContext()
    @drawItemManager.draw(context)    
  end
end
