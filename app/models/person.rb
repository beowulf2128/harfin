class Person < ApplicationRecord

  has_one    :user
  has_many   :registrations
  has_many   :truthbooksignatures, :class_name=> "Truthbooksignature", :foreign_key=>'clubber_id'
  has_many   :attendances, :class_name=>"Attendance", :foreign_key=>'attender_id'
  has_many   :scores, :class_name=>"Score", :foreign_key=>'clubber_id'
  has_many   :vwscores, :class_name=>"Vwscore", :foreign_key=>'clubber_id'

  scope :sorted, lambda { order('last_name, first_name') }

  def name_lf
    Person.name_lf(last_name, first_name)
  end
  def name_fl
    Person.name_fl(last_name, first_name)
  end
  def self.name_lf(ln, fn)
    [ln, fn].delete_if{|n| n.blank?}.join(', ')
  end
  def self.name_fl(ln, fn)
    [fn, ln].delete_if{|n| n.blank?}.join(' ')
  end

  def current_registration()
    @current_registration ||= Registration.for_person_in(self, Sessionyear.current).first
  end

=begin
  def current_truthbook_section
    @current_truthbook_section ||=  Truthbooksection.current_tbsec_sort_for_user_sql ...NEEDED? TODO
  end
=end

  def current_truthbook
    return @current_truthbook unless @current_truthbook.nil?
    sub_sql = Truthbooksection.current_tbsec_sort_for_user_sql(self.id)
    tb = Truthbook.where("(truthbooksections.sort-1) = #{sub_sql}").joins(:truthbooksections).first
    @current_truthbook = tb || Truthbook.new # blank book

  end

  def next_truthbook_section
    truthbooksignatures.joins(:truthbooksection).maximum('truthbooksections.sort')+1
  end

  def attendances_in(sessionyear)
    attendances.joins(:sessionday).where(:sessiondays=>{:sessionyear_id=>sessionyear.id})
  end

  def scores_in(sessionyear)
    # join back to parent tables
    scores.joins(:attendance=>:sessionday).where(:sessiondays=>{:sessionyear_id=>sessionyear.id} )

  end

  def current_points
    @current_points ||= scores_in(Sessionyear.current).sum(:point_value)
  end

end
