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

  # Holidays that effect the schedule
  HOLIDAY_NAMES = ['Labor Day', 'Thanksgiving', 'Christmas Day', "New Year's Day", 'Easter Sunday', 'Memorial Day']
  def self.get_holidays_between(start_date, end_date)
    cal_days = {}
    all_hd = Holidays.between(start_date, end_date, :us)

    all_hd.each do |d|
      # no spaces or apostrophes
      sym = d[:name].downcase.gsub(' ','_').gsub("'",'').to_sym
      cal_days[sym] = d[:date] if HOLIDAY_NAMES.include?(d[:name])
    end
    return cal_days
  end

  def self.is_club_night?(date, holidays)
    # Fall semester - start after LD, 3 Sundays in Dec off
    return true if date.between?(holidays[:labor_day],
                                 holidays[:christmas_day] - 2.weeks - 1.day)
    # Spring semester - start after NY, stop before Memorial Day. Skip Easter
    return true if date.between?(holidays[:new_years_day] + 1.day,
                                 holidays[:memorial_day] - 2.days) && # a Monday
                      date != holidays[:easter_sunday]
   return false
  end

  def make_new_stub_cal
    # 1) Find all Sunday dates from for the year
    all_days = (start_date.to_date..end_date.to_date).to_a.select {|k| k.wday == 0 }  # 0 is Sunday
    holidays = Sessionyear.get_holidays_between(self.start_date, self.end_date)

    all_days.each do |day|
      sessiondays.build({
        sd_date:  day,
        is_club_night: Sessionyear.is_club_night?(day, holidays)
      })
    end


  end

end
