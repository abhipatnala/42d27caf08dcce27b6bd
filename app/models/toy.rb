class Toy < ApplicationRecord
  validates :facing, :inclusion => { :in => %w[NORTH SOUTH WEST EAST] }
  validates_numericality_of :x_coordinate,
    greater_than_or_equal_to: 0,
    less_than: 5

  validates_numericality_of :y_coordinate,
    greater_than_or_equal_to: 0,
    less_than: 5

  def process_request(orders)
    res = {}
    orders.each do |order|
      if order == 'REPORT' && self.valid?
        res = self.reload.current_location
        break
      end
      self.process_order(order)
    end

    res
  end

  def current_location
    {
      location: [x_coordinate, y_coordinate, facing]
    }
  end

  private

  def process_order command_string
    command_params = command_string.split(' ')

    order = command_params.first

    if order == 'PLACE'
      process_place(command_params[1])
    elsif order == 'LEFT'
      process_left
    elsif order == 'RIGHT'
      process_right
    elsif order == 'MOVE'
      process_move
    end

    self.save
  end


  def process_left
    case self.facing
    when 'NORTH'
      self.facing = 'WEST'
    when 'SOUTH'
      self.facing = 'EAST'
    when 'EAST'
      self.facing = 'NORTH'
    when 'WEST'
      self.facing ='SOUTH'
    end
  end

  def process_right
    case self.facing
    when 'NORTH'
      self.facing = 'EAST'
    when 'SOUTH'
      self.facing = 'WEST'
    when 'EAST'
      self.facing = 'SOUTH'
    when 'WEST'
      self.facing = 'NORTH'
    end
  end

  def process_move
    case self.facing
    when 'NORTH'
      self.y_coordinate += 1
    when 'SOUTH'
      self.y_coordinate -=1
    when 'EAST'
      self.x_coordinate +=1
    when 'WEST'
      self.x_coordinate -=1
    end
  end

  def process_place position_info
    position_info = position_info.split(',')

    self.x_coordinate = position_info[0].to_i
    self.y_coordinate = position_info[1].to_i
    self.facing = position_info[2]
  end
end
