class PenStateViewController < UIViewController
  BUTTON_SIZE = 44

  attr_reader :frameSize
  attr_accessor :popover, :pen
  
  def create_button(color, left, top)
    button = UIButton.buttonWithType(UIButtonTypeCustom)
    button.frame = CGRectMake(left, top, BUTTON_SIZE, BUTTON_SIZE)
    button.setBackgroundColor(color)
    button.addTarget(self, action: "select_color:",
                 forControlEvents: UIControlEventTouchUpInside)
    
    view.addSubview(button) 
  end
  
  def select_color(button)
      @pen.color = button.backgroundColor.CGColor
      @popover.dismissPopoverAnimated(true)
      @popover.delegate.popoverControllerDidDismissPopover(@popover)
  end
  
  def viewDidLoad
    margin = 8
    left = 14
    top = 14
    row = 2
    col =3

    @frameSize = CGSizeMake(
       left * 2 + (BUTTON_SIZE + margin) * col - margin,
       top * 2 + (BUTTON_SIZE + margin) * row - margin)
   
    create_button(UIColor.blackColor, left, top)
    create_button(UIColor.redColor,  left + BUTTON_SIZE + margin, top)
    create_button(UIColor.greenColor,  left + (BUTTON_SIZE + margin) * 2, top)

    top += BUTTON_SIZE + margin
    create_button(UIColor.blueColor, left, top)
    create_button(UIColor.yellowColor,  left + BUTTON_SIZE + margin, top)
    create_button(UIColor.orangeColor,  left + (BUTTON_SIZE + margin) * 2, top)

  end

end
