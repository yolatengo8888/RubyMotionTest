class DrawViewController < UIViewController
  def loadView
    @drawItemManager = DrawItemManager.new
    drawBoardView = DrawBoardView.alloc.init
    drawBoardView.backgroundColor = UIColor.whiteColor
    drawBoardView.drawItemManager = @drawItemManager

    self.view = drawBoardView
  end

  def viewDidLoad
    @pen = Pen.new(UIColor.blackColor.CGColor, 5)
    
    screenSize = UIScreen.mainScreen.applicationFrame.size
    buttonImage = UIImage.imageNamed('pen-48.png')
    
    @btnPen = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @btnPen.addTarget(self, action:'show_pen_state:', forControlEvents:UIControlEventTouchUpInside)
    @btnPen.frame = CGRectMake(
      (screenSize.width  - buttonImage.size.width) / 2, 
      screenSize.height - buttonImage.size.height - 8, 
      buttonImage.size.width, buttonImage.size.height)
    @btnPen.setBackgroundImage(buttonImage, forState:UIControlStateNormal)
    @btnPen.layer.setCornerRadius(10)
    @btnPen.layer.setBorderWidth(2)
    @btnPen.setClipsToBounds(true)    
    view.addSubview(@btnPen)    

    penStateViewController = PenStateViewController.alloc.init
    penStateViewController.view.backgroundColor = UIColor.whiteColor
    penStateViewController.pen = @pen
    @penStateViewPopover = UIPopoverController.alloc.initWithContentViewController(penStateViewController)
    @penStateViewPopover.popoverContentSize = penStateViewController.frameSize
    @penStateViewPopover.delegate = self
    penStateViewController.popover = @penStateViewPopover
  end

  def popoverControllerDidDismissPopover(popoverController)
    @btnPen.layer.setBorderColor(@pen.color)
  end
  
  def show_pen_state(button)    
    @penStateViewPopover.presentPopoverFromRect(
      @btnPen.bounds, inView:button, permittedArrowDirections:UIPopoverArrowDirectionAny, animated:true)
  end

  def get_point(touches)
    touch = touches.anyObject
    point = touch.locationInView(self.view)
  end
  
  def touchesBegan(touches, withEvent:event)
    point = get_point(touches)
    line = LineItem.new(point, @pen.color, @pen.bold)
    @drawItemManager.draw_begin(line)
  end

  def touchesMoved(touches, withEvent:event)
    @drawItemManager.draw_move(get_point(touches))
    self.view.setNeedsDisplay
  end

  def touchesEnded(touches, withEvent:event)
    @drawItemManager.draw_end
    self.view.setNeedsDisplay
  end  
end
