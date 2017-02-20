class CalBuilder


  # Holidays that  the schedule
  HOLIDAY_NAMES = ['Labor Day', 'Thanksgiving', 'Christmas Day', "New Year's Day",
                   'Easter Sunday', 'Memorial Day']
  def self.get_holidays_between(start_date, end_date)
    cal_days = {}
    all_hd = Holidays.between(start_date, end_date, :us, :ca) # need :ca for Easter

    all_hd.each do |d|
      # no spaces or apostrophes
      sym = d[:name].downcase.gsub(' ','_').gsub("'",'').to_sym
      cal_days[sym] = d[:date] if HOLIDAY_NAMES.include?(d[:name])
    end
    return cal_days
  end


  def self.build_draft(session_year)
  #def make_new_stub_cal
    sy = session_year
    # 1) Find all Sunday dates from for the year
    all_days = CalBuilder.sundays_between(sy.start_date, sy.end_date)
    holidays = CalBuilder.get_holidays_between(sy.start_date, sy.end_date)

    all_days.each do |day|
      sy.sessiondays.build({
        sd_date:  day,
        is_club_night: is_club_night?(day, holidays)
      })
    end
  end

  def self.sundays_between(start_date, end_date)
    s = start_date.to_date
    e = end_date.to_date
    # 0 is Sunday
    days = (s..e).to_a.select {|k| k.wday == 0 }
    return days
  end

  def self.draft_events_for_date(date, holidays)
    # Fall semester - start after LD, 3 Sundays in Dec off
    last_fall_day = holidays[:christmas_day] - 2.weeks - 1.day
    if date.between?(holidays[:labor_day], last_fall_day)
      return {:is_club_night => true, :events=>[]}
    end

    # Christmas break
    day_after_ny = holidays[:new_years_day] + 1.day
    if date.between?(last_fall_day, day_after_ny)
      return {:is_club_night => false, :events=>['Christmas break']}
    end

    # Spring semester - start after NY, stop before Memorial Day. Skip Easter
    if date.between?(day_after_ny, holidays[:memorial_day] - 2.days)  # a Monday
      if date == holidays[:easter_sunday]
        return {:is_club_night => false, :events=>['Easter break']}
      else
        return {:is_club_night => true, :events=>[]}
      end
    end
    raise 'Date is out of range! (off calendar)'
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

end
