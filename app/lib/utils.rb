module Utils

  def self.date_fmt(date)
    return '' if date.blank?
    d = date.strftime('%Y/%m/%d %l:%M%P')
    d.sub(' 12:00am', '')
  end

end
