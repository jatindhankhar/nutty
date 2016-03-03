class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.text :lyric
      t.integer :upvote, default: 0
      t.integer :downvote, default: 0
      t.timestamps
    end
  end
end
