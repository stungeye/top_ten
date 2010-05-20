class EnhanceArtists < ActiveRecord::Migration
  def self.up
    add_column :artists, :mbid, :string
    add_column :artists, :lastfm_url, :string
    add_column :artists, :similar_artists_data, :string
    add_column :artists, :images_data, :string
    add_column :artists, :tags_data, :string
    add_column :artists, :bio_data, :string
  end

  def self.down
    remove_coumn :artists, :mbid
    remove_coumn :artists, :lastfm_url
    remove_coumn :artists, :similar_artists_data
    remove_coumn :artists, :images_data
    remove_coumn :artists, :tags_data
    remove_coumn :artists, :bio_data
  end
end
