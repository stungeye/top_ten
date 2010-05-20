# Last.rm Ruby API Wrapper
#
# Author   : Wally Glutton - http://stungeye.com
# Required : HTTParty gem - http://httparty.rubyforge.org/
# Required : Last.fm API Key - http://www.last.fm/api
# License  : This is free and unencumbered software released into the public domain.

require 'rubygems'
require 'httparty'

class QueryStatusFail < StandardError; end

class LastFM
  include HTTParty
  base_uri 'http://ws.audioscrobbler.com/2.0/'
  format :xml
  
  def initialize( key )
    self.class.default_params :api_key => key
  end
  
  def q( options )
    response = self.class.get( '', :query => options )['lfm']
    if response['status'] != 'ok'
      raise QueryStatusFail, response['error']
    end
    response
  end
  
  #artist_search[]
  #  name
  #  url
  #  mbid
  #  image[]
  
  def artist_search( artist )
    q( :method => 'artist.search', :artist => artist )['results']['artistmatches']['artist']
  end
  
 #album_search[]
  #  name
  #  url
  #  mbid
  #  image[]
  
  def album_search( album )
    q( :method => 'album.search', :album => album )['results']['albummatches']['album']
  end
   
  #artist_top_albums[]
  #  name
  #  mbid
  #  rank
  #  image[]
  #  artist{ 'name' 'url' 'mbid' }
  #  url
  
  def artist_top_albums( artist )
    q( :method => 'artist.gettopalbums', :artist => artist )['topalbums']['album']
  end
  
  #artist_top_tracks[]
  # name
  # artist{ name url mbid }
  # url
  # rank
  # mbid
  # image[]
  
  def artist_top_tracks( artist )
    q( :method => 'artist.gettoptracks', :artist => artist )['toptracks']['track']
  end
  
  #artist_top_tags[]
  #  name
  #  url
  #  count
  
  def artist_top_tags( artist )
    q( :method => 'artist.gettoptags', :artist => artist )['toptags']['tag']
  end
  
  #artist_events[]
  #  artists{ 'artist' 'headliner' }
  #  title
  #  url
  #  startDate
  #  id
  #  tags['tag'][]
  #  website
  #  tickets
  #  venue{ 'name' 'website' location{ 'city' 'country' 'postalcode' 'street' 'geo:point' }}
  #  description
  #  image[]
  
  def artist_events( artist )
    response = q( :method => 'artist.getevents', :artist => artist )['events']
    (response['total'].to_i == 0) ? [] : response['event']
  end
  
  #album_info
  #  name
  #  artist
  #  releasedate
  #  url
  #  id
  #  mbid
  #  toptags['tag'][]{ 'name' 'url' }
  #  image[]
  #  wiki{ 'published' 'content' 'summary'}
  
  def album_info( artist, album )
    q( :method => 'album.getinfo', :artist => artist, :album => album )['album']
  end
  
  def album_info_by_mbid( mbid )
    q( :method => 'album.getinfo', :mbid => mbid )['album']
  end
  
  #artist info
  #  name
  #  mbid
  #  url
  #  image[]
  #  similar['artist'][]{ 'name' 'url' 'image'[] }
  #  tags['tag'][]{ 'name' 'url' }
  #  bio{ 'published' 'summary' 'content' }
  
  def artist_info( artist )
    q( :method => 'artist.getinfo', :artist => artist )['artist']
  end
  
  def artist_info_by_mbid( mbid )
    q( :method => 'artist.getinfo', :mbid => mbid )['artist']
  end
  
end

