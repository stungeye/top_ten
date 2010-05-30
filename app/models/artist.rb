class Artist < ActiveRecord::Base
  DATA_COLUMNS = [:similar_artists_data, :images_data, :tags_data, :bio_data]
  has_many :albums
  
  #before_save :marshal_objects
  #after_save  :unmarshal_objects
  #
  #def marshal_objects
  #  DATA_COLUMNS.each do |attr|
  #    self[attr]  = self[attr].nil? ? nil : Base64.encode64(Marshal.dump(self[attr]))
  #  end
  #end
  #
  #def unmarshal_objects
  #  DATA_COLUMNS.each do |attr|
  #    puts Base64.decode64(self[attr])
  #    self[attr] = self[attr].nil? ? nil : Marshal.load(Base64.decode64(self[attr]))
  #    
  #  end
  #end
  #
  #def after_find
  #  unmarshal_objects
  #end

end