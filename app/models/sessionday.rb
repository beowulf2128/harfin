class Sessionday < ApplicationRecord
  belongs_to :sessionyear
  has_many :scores

  scope :sorted,      -> { order(:sd_date) }
  scope :desc,      -> { order("sd_date DESC") }
  scope :club_nights, -> { where(is_club_night: true) }

  # Is the current or upcoming sessionday
  def is_current?
    today = Date.today
    self.sd_date.between?(today, today + 6)
  end
  # For labels that need to include the Sessionyear theme
  def out_sy
    "#{self.sd_date.to_s(:mdy) } --- #{sessionyear.theme} "
  end

end
