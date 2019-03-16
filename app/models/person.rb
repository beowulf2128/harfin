class Person < ApplicationRecord

  has_one    :user
  has_many   :registrations
  has_many   :truthbooksignatures, :class_name=> "Truthbooksignature", :foreign_key=>'clubber_id'
  has_many   :attendances, :class_name=>"Attendance", :foreign_key=>'attender_id'
  has_many   :scores, :class_name=>"Score", :foreign_key=>'clubber_id'

  scope :sorted, lambda { order('last_name, first_name') }

  def name_lf
    [last_name, first_name].delete_if{|n| n.blank?}.join(', ')
  end
  def name_fl
    [first_name, last_name].delete_if{|n| n.blank?}.join(' ')
  end

  def attendances_in(sessionyear)
    attendances.joins(:sessionday).where(:sessiondays=>{:sessionyear_id=>sessionyear.id})
  end

  def scores_in(sessionyear)
    # join back to parent tables
    scores.joins(:attendance=>:sessionday).where(:sessiondays=>{:sessionyear_id=>sessionyear.id} )

  end
end
