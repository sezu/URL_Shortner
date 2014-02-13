class CreateTagging < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tag_topic_id
      t.integer :shortened_url_id

      t.timestamps
    end

    create_table :tag_topics do |t|
      t.string :tag_topic

      t.timestamps
    end
  end
end
