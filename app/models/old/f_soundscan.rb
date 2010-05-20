class FSoundscan

	include Friendly::Document
	attribute :year, Integer
	attribute :sales, Integer
	attribute :f_album_id, Friendly::UUID

	indexes :year
	indexes :sales
	indexes :f_album_id

end
