class Sessionday < ApplicationRecord
  belongs_to :sessionyear

  def is_current?
    self.sd_date.between?(Date.today, 6.days.from_now)
  end

end
