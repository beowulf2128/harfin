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

  def next_truthbook_section_sort_id
    (truthbooksignatures.joins(:truthbooksection).maximum('truthbooksections.sort') || 0) + 1
  end

  # TODO include skipped sections first!!!
  def next_truthbook_sections(how_many=5)
    #next_id = next_truthbook_section_sort_id
    #Truthbooksection.where(sort: next_id..(next_id+how_many-1)).sorted

    tbk_start_sort = Truthbooksection.start_sort_for_book(self.current_truthbook)
    Truthbooksection.
      joins("LEFT JOIN truthbooksignatures signas ON (signas.truthbooksection_id = truthbooksections.id and signas.clubber_id = #{self.id} )").
      where("signas.id is null").
      where(["sort >= ?", tbk_start_sort]).sorted.limit(how_many)
  end

  def attendances_in(sessionyear)
    attendances.joins(:sessionday).where(:sessiondays=>{:sessionyear_id=>sessionyear.id})
  end

  def scores_in(sessionyear)
    # join back to parent tables
    scores.joins(:attendance=>:sessionday).where(:sessiondays=>{:sessionyear_id=>sessionyear.id} )

  end

  def current_points
    return @current_points if @current_points.present?
    sy = Sessionyear.current
    return @current_points = 0 if sy.nil?
    @current_points = scores_in(Sessionyear.current).sum(:point_value)
  end

end
