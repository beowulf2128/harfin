class Truthbooksection < ApplicationRecord
  belongs_to :truthbook

  scope :sorted, -> { order(:sort) }

  def out
    "#{truthbook.name} #{unit}-#{section}"
  end

  def section_type
    return section if section =~ /Training|Final/
    return 'Section'
  end
end
