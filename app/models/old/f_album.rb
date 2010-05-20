class FAlbum

	include Friendly::Document

	attribute :title, String
	attribute :f_artist_id, Friendly::UUID
	attribute :wikipedia_url, String
	attribute :mbid, String
	#attribute :release_date, Date
	attribute :lastfm_url, String
	attribute :top_tags_data, String
	attribute :images_data, String
	attribute :description_data, String

	indexes :f_artist_id
	indexes :title
	#indexes :release_date
	
	has_many :f_soundscans
end
