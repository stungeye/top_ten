class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.string :title
      t.string :wikipedia_url
      t.int :artist_id

      t.timestamps
    end
  end

  def self.down
    drop_table :albums
  end
end
