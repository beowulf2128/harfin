class Sessionyear < ApplicationRecord

  validates_presence_of :start_date
  validates_presence_of :end_date

  #
  def self.current
    where(['start_date < ? and end_date > ?', Time.now, Time.now]).first
  end
end
