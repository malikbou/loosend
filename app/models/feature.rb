class Feature < ApplicationRecord
  has_many :toilet_features
  has_many :toilets, through: :toilet_features

  def icon
    case name
    when 'Gender Neutral'
      return "blue-uni.png"
    when 'Enclosed Stall'
      return "door.png"
    when 'Hand Dryer'
      return "hand-dryer.png"
    when 'Paper Towels'
      return "paper-towel.png"
    when 'Baby Changing'
      return "baby-boy.png"
    when 'Accessible'
      return "disability.png"
    when 'Private Sink'
      return "sink.png"
    when 'Spacious'
      return "spacious.png"
    when 'Mirror'
      return "mirror.png"
    when 'Sanitary Bin'
      return "bin.png"
    end
  end
end
