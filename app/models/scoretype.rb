class Scoretype < ApplicationRecord

  has_many :truthbooksections

  # Scoretypes relating to truthbook signatures
  BBA_TYPES = %w{Book Bible Attendance} # TODO dumb name. Should be db flag?
  SIGNA_TYPES = %w{Section Training Final}
  OTHER_TYPES = %w{Friend ThemeParticipation Team}

  SIGNAS_AWARDS = {}
  SIGNAS_AWARDS[Registration::OLDER] = {'Gold':72, 'Silver':48}
  SIGNAS_AWARDS[Registration::YOUNGER] = {'Gold':48, 'Silver':32}

  def self.book
    find_by_name 'Book'
  end
  def self.bible
    find_by_name 'Bible'
  end

end
