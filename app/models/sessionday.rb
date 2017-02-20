class Sessionday < ApplicationRecord
  belongs_to :sessionyear

  def is_current?
    today = Date.today
    self.sd_date.between?(today, today + 6)
  end

end
