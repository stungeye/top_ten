class EnhanceAlbums < ActiveRecord::Migration
  def self.up
    add_column :albums, :mbid, :string
    add_column :albums, :release_date, :datetime
    add_column :albums, :lastfm_url, :string
    add_column :albums, :top_tags_data, :string
    add_column :albums, :images_data, :string
    add_column :albums, :description_data, :string
  end

  def self.down
    remove_column :albums, :mbid
    remove_column :albums, :release_date
    remove_column :albums, :lastfm_url
    remove_column :albums, :top_tags_data
    remove_column :albums, :images_data
    remove_column :albums, :description_data
  end
end
