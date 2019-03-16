class Scoretype < ApplicationRecord
  def self.book
    find_by_name 'Book'
  end
  def self.bible
    find_by_name 'Bible'
  end
end
