class TagTopic < ActiveRecord::Base
  validates :tag_topic, :presence => :true

  has_many(
    :tags,
    :primary_key => :id,
    :foreign_key => :tag_topic_id,
    :class_name => "Tagging"
  )

  has_many(
    :urls,
    :through => :tags,
    :source => :url
  )

  def self.create_tag(tag_topic)
    TagTopic.create!(:tag_topic => tag_topic)
  end
end