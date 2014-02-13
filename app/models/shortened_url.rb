class ShortenedUrl < ActiveRecord::Base
  validates :submitter_id, :presence => true
  validates :short_url, :uniqueness => true
  validates :long_url, length: {maximum: 1024}

  belongs_to(
    :submitter,
    :primary_key => :id,
    :foreign_key => :submitter_id,
    :class_name => "User"
  )

  has_many(
    :visits,
    :primary_key => :id,
    :foreign_key => :shortened_url_id,
    :class_name => "Visit"
  )

  has_many(
  :visitors,
  :through => :visits, :uniq => true,
  :source => :visitor
  )

  has_many(
    :tags,
    :primary_key => :id,
    :foreign_key => :shortened_url_id,
    :class_name => "Tagging"
  )

  has_many(
    :tag_topics,
    :through => :tags,
    :source => :tag_topic
  )

  def self.random_code
    code = nil
    until code
      super_safe_code = SecureRandom::urlsafe_base64
      code = super_safe_code unless ShortenedUrl.exists?(:short_url => super_safe_code)
    end
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    code = random_code.to_s
    ShortenedUrl.create!(:submitter_id => user.id, :long_url => long_url, :short_url => code)
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    self.visits.where("created_at > ?", 10.minutes.ago).count
  end
end