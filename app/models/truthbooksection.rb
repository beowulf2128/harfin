class Truthbooksection < ApplicationRecord
  belongs_to :truthbook
  belongs_to :scoretype

  scope :sorted, -> { order(:sort) }

  def out
    Truthbooksection.formatted(truthbook.name, unit, section)
  end

  def section_type
    return section if section =~ /Training|Final/
    return 'Section'
  end

  def self.current_tbsec_sort_for_user_sql(person_id)
    %Q~ (
      select max(tbsecs.sort) as current_tbsec_sort
      from truthbooksections tbsecs
        inner join truthbooksignatures tbsignas on tbsignas.truthbooksection_id = tbsecs.id
        where
          clubber_id = #{person_id} ) ~
  end

  # Returns the first truthbooksection sort number for a given book
  # book_name - a/r model
  def self.start_sort_for_book(truthbook)
    Truthbooksection.joins(:truthbook).where(truthbook: truthbook).minimum(:sort)
  end

  def self.formatted(book_name, unit, section)
    return '' if book_name.blank?
    "#{book_name} #{unit}-#{section}"
  end
end
