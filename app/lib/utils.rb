module Utils

  def self.date_fmt(date)
    return '' if date.blank?
    d = date.strftime('%Y/%m/%d %l:%M%P')
    d.sub(' 12:00am', '')
  end

  # checkbox form submission value to true or false
  def self.cb_to_tf(cb_val)
    [true,"true", 1, "1", "on"].include?(cb_val)
  end

end
