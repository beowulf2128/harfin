class Scoretype < ApplicationRecord

  has_many :truthbooksections
  scope :active, lambda { where(active: true) }

  # Scoretypes relating to truthbook signatures
  BBA_TYPES = %w{Book Bible Attendance} # TODO dumb name. Should be db flag?
  SIGNA_TYPES = %w{Section Training Final}
  OTHER_TYPES = %w{Friend ThemeParticipation Team}

  SIGNAS_AWARDS = {}
  SIGNAS_AWARDS[Registration::OLDER] = {'Gold':72, 'Silver':48}
  SIGNAS_AWARDS[Registration::YOUNGER] = {'Gold':48, 'Silver':32}

  def name_points
    "#{name} - #{suggested_point_value}"
  end

  def self.book
    find_by_name 'Book'
  end
  def self.bible
    find_by_name 'Bible'
  end
  def self.attendance
    find_by_name 'Attendance'
  end
  def self.section
    find_by_name 'Section'
  end

end
