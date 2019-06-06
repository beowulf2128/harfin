class Sessionday < ApplicationRecord
  belongs_to :sessionyear
  has_many :scores

  scope :sorted,      -> { order(:sd_date) }
  scope :club_nights, -> { where(is_club_night: true) }

  # Is the current or upcoming sessionday
  def is_current?
    today = Date.today
    self.sd_date.between?(today, today + 6)
  end

end
