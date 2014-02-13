class Visit < ActiveRecord::Base
  validates :user_id, :shortened_url_id, :presence => :true

  def self.record_visit!(user, shortened_url)
    Visit.create!(:user_id => user.id, :shortened_url_id => shortened_url.id)
  end

  belongs_to(
  :visited_url,
  :primary_key => :id,
  :foreign_key => :shortened_url_id,
  :class_name => "ShortenedUrl"
  )

  belongs_to(
  :visitor,
  :primary_key => :id,
  :foreign_key => :user_id,
  :class_name => "User"
  )

end