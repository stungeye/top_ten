class Album < ActiveRecord::Base
  validates_length_of :title, :minimum => 10
  DATA_COLUMNS = [:top_tags_data, :images_data, :description_data]
  belongs_to :artist
  has_many :soundscans
  
  before_save :marshal_objects
  after_save  :unmarshal_objects
  
  def marshal_objects
    DATA_COLUMNS.each do |attr|
      self[attr]  = self[attr].nil? ? nil : Base64.encode64(Marshal.dump(self[attr]))
    end
  end
  
  def unmarshal_objects
    DATA_COLUMNS.each do |attr|
      self[attr] = self[attr].nil? ? nil : Marshal.load(Base64.decode64(self[attr]))
    end
  end
  
  def after_find
    unmarshal_objects
  end
end
