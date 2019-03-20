class Truthbooksection < ApplicationRecord
  belongs_to :truthbook

  scope :sorted, -> { order(:sort) }

  def out
    formatted(truthbook.name, unit, section)
  end

  def section_type
    return section if section =~ /Training|Final/
    return 'Section'
  end

  def self.formatted(book_name, unit, section)
    return '' if book_name.blank?
    "#{book_name} #{unit}-#{section}"
  end
end
