class DrawItemManager

  def initialize
    @drawItems =[]
    @activeItem = nil
  end

  def add(item)
    @drawItems.push(item)
  end

  def draw(context)
    @drawItems.each do |item|
      item.draw(context)
    end
    @activeItem.draw(context) if @activeItem != nil
  end
  
  def draw_begin(newItem)
    @activeItem = newItem
  end

  def draw_move(point)
    @activeItem.draw_move(point)
  end

  def draw_end
    @activeItem.draw_end
    @drawItems.push(@activeItem)
    @activeItem = nil
  end  
end
