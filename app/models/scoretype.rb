class Scoretype < ApplicationRecord

  # Scoretypes relating to truthbook signatures
  SIGNA_TYPES = %w{Section Training Final}

  SIGNAS_AWARDS = {}
  SIGNAS_AWARDS[Registration::OLDER] = {'Gold':72, 'Silver':60}
  SIGNAS_AWARDS[Registration::YOUNGER] = {'Gold':48, 'Silver':32}

  def self.book
    find_by_name 'Book'
  end
  def self.bible
    find_by_name 'Bible'
  end

end
