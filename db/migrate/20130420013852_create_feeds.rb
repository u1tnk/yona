class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.string :feed_url
      t.string :html_url
      t.string :type

      t.timestamps
    end
  end
end
