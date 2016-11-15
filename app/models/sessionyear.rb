class Sessionyear < ApplicationRecord

  has_many :sessiondays

  scope :sorted, -> { order('start_date desc') }

  validates_presence_of :start_date
  validates_presence_of :end_date

  #
  def self.current
    where(['start_date < ? and end_date > ?', Time.now, Time.now]).first
  end

  def self.vals_for_select
    vals = []
    sorted.limit(5).each do |sy|
      vals << [sy.year, sy.id]
    end
    return vals
  end

  def year
    "#{start_date.to_formatted_s(:year)}-#{end_date.to_formatted_s(:year)}"
  end


  def make_new_stub_cal
    # 1) Find all Sunday dates from for the year
    all_days = (start_date.to_date..end_date.to_date).to_a.select {|k| k.wday == 0 }  # 0 is Sunday
    all_days.each do |day|
      sessiondays.build({
        sd_date:  day
      })
    end

    # 2) Mark club nights - between Labor Day and Memorial Day
    # Days to skip
    # - Christmas and the 2 prior Sundays
    # - Easter

  end

end
