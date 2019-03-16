class Sessionday < ApplicationRecord
  belongs_to :sessionyear

  scope :sorted,      -> { order(:sd_date) }
  scope :club_nights, -> { where(is_club_night: true) }

  def is_current?
    today = Date.today
    self.sd_date.between?(today, today + 6)
  end

end
