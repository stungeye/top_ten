class FArtist

	include Friendly::Document

	attribute :name, String
	attribute :wikipedia_url, String
	attribute :mbid, String
	attribute :lastfm_url, String
	attribute :similar_artists_data, String
	attribute :images_data, String
	attribute :tags_data, String
	attribute :bio_data, String

	has_many :f_albums

	indexes :name

end
