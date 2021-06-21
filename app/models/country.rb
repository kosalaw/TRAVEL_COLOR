class Country < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :alerts, dependent: :destroy

  def color_code
    case color
    when 'Amber'
      "#ff8800"
    when 'Green'
      "#00a891"
    when 'Red'
      "#cc0022"
    else
      color
    end
  end
end
