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

  def has_cal?
    return sessiondays.count > 0
  end

end
