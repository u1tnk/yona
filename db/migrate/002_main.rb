class Main < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :url
      t.string :title
      t.string :html_url
      t.string :kind

      t.timestamps
    end
    add_index :feeds, [:url], unique: true

    create_table :user_feeds do |t|
      t.integer :user_id
      t.integer :feed_id, index: true

      t.timestamps
    end
    add_index :user_feeds, [:user_id, :feed_id], unique: true

    create_table :tags do |t|
      t.integer :user_id
      t.string :label

      t.timestamps
    end
    add_index :tags, [:user_id, :label], unique: true

    create_table :feed_tags do |t|
      t.integer :feed_id
      t.integer :tag_id, index: true

      t.timestamps
    end
    add_index :feed_tags, [:feed_id, :tag_id], unique: true
  end
end
