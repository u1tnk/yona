class Main < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :url, null: false
      t.string :title, null: false
      t.string :html_url, null: false
      t.string :kind, null: false
      t.string :creator
      t.string :etag
      t.datetime :last_modified_at
      t.integer :articles_count, null: false, default: 0
      t.integer :articles_count, null: false, default: 0

      t.timestamps
    end
    add_index :feeds, [:url], unique: true

    create_table :user_feeds do |t|
      t.integer :user_id, null: false
      t.integer :feed_id, null: false, index: true

      t.timestamps
    end
    add_index :user_feeds, [:user_id, :feed_id], unique: true

    create_table :tags do |t|
      t.integer :user_id, null: false
      t.string :label, null: false

      t.timestamps
    end
    add_index :tags, [:user_id, :label], unique: true

    create_table :feed_tags do |t|
      t.integer :feed_id, null: false
      t.integer :tag_id, index: true, null: false

      t.timestamps
    end
    add_index :feed_tags, [:feed_id, :tag_id], unique: true

    create_table :articles do |t|
      t.integer :feed_id, null: false
      t.string :title, null: false
      t.string :url, null: false
      t.column :content, 'mediumtext'
      t.string :author
      t.datetime :published_at

      t.timestamps
    end
    add_index :articles, [:feed_id, :published_at]
    add_index :articles, [:url], unique: true

    create_table :article_read_logs do |t|
      t.integer :user_id, null: false
      # 冗長だけど、既読チェックの処理が簡潔になる
      t.integer :feed_id, null: false
      t.integer :article_id, null: false

      t.timestamps
    end
    add_index :article_read_logs, [:user_id, :feed_id, :article_id], unique: true
  end
end
