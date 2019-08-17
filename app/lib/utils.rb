module Utils

  def self.or_ary(val)
    val || []
  end

  def self.date_fmt(date)
    return '' if date.blank?
    d = date.strftime('%Y/%m/%d %l:%M%P')
    d.sub(' 12:00am', '')
  end

  # checkbox form submission value to true or false
  def self.cb_to_tf(cb_val)
    [true,"true", 1, "1", "on"].include?(cb_val)
  end

  # Returns the hash keys where the value is checkbox truthy or falsy
  # Params:
  #   cb_hash - {"1"=>"on", "2"=>"", "3"=>"off", ...}
  #   bool - true/false
  def self.extract_matching_ids_from(cb_hash, bool)
    true_ids = []
    cb_hash.each do |id, on_off|
      true_ids << id if Utils.cb_to_tf(on_off) == bool
    end
    return true_ids
  end

end
