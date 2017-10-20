class Picture < ApplicationRecord
  belongs_to :user

  validates :artist, :title, :url, presence: true
  validates :title, length: { minimum: 3, maximum: 20 }
  validates :url, uniqueness: true
  validates :url, format: URI::regexp(%w(http https))

  def self.newest_first
    Picture.order("created_at DESC")
  end

  def self.most_recent_five
    Picture.newest_first.limit(5)
  end

  def self.created_before(time)
    Picture.where("created_at < ?", time)
  end

  def self.pictures_created_in_year(year)
    # Picture.where("created_at >= ?", "#{year}-01-01 01:01:01").where("created_at <= ?", "#{year}-12-31 23:59:59")

    # OR
    # Picture.where("created_at >= ? and created_at <= ?", "#{year}-01-01 01:01:01", "#{year}-12-31 23:59:59")

    # OR
    # Picture.where("created_at >= :start and created_at <= :end", start: "#{year}-01-01 01:01:01", end: "#{year}-12-31 23:59:59")

    # OR - using postgres function
    Picture.where("created_at BETWEEN :start AND :end", start: "#{year}-01-01 01:01:01", end: "#{year}-12-31 23:59:59")
  end

end
