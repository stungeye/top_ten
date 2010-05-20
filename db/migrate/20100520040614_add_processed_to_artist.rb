class AddProcessedToArtist < ActiveRecord::Migration
  def self.up
    add_column :artists, :processed_similar, :boolean
    add_column :artists, :processed_top_albums, :boolean
  end

  def self.down
    remove_column :artists, :processed_similar
    remove_column :artists, :processed_top_albums
  end
end
