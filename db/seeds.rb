WORKING_DIR = File.dirname(__FILE__)
require 'rubygems'
require 'nokogiri'
require 'glutton_lastfm'
#require WORKING_DIR + '/last_fm_ruby.rb'

 
 #Artist
 #  Name
 #  Wiki Link
 #  Album
 #    Name
 #    Wiki Link
 #    Soundtrack
 #    Various Artists
 #    Sales
 #      Year
 #        Amount

last = GluttonLastfm.new '923a366899eebed73ba992fff9be063e'
#
#top_albums = Nokogiri::HTML(File.new(WORKING_DIR + '/seeds.html'), nil, 'UTF-8')
#
#parsed_artists = {}
#
#list_years = top_albums.xpath('//div')
#
#list_years.each do |list_year|
#  current_year = list_year.xpath('./h3')[0].inner_html
#  albums = list_year.xpath('./ol/li')
#  albums.each do |album|
#    
#    album_node_string = album.inner_html
#    album_sales       = album_node_string.split('~')[1].strip.gsub(',','').to_i
#    
#    album_link        = album.xpath('./i/a')[0]
#    album_name        = album_link.child.to_xhtml(:encoding => 'UTF-8')
#    album_wiki_url    = album_link['href']
#    
#    artist_link       = album.xpath('./a')[0]
#    artist_name       = artist_link.child.to_xhtml(:encoding => 'UTF-8')
#    artist_wiki_url   = artist_link['href']
#    
#    if parsed_artists[artist_name].nil?
#      parsed_artist = {}
#      parsed_artist[:albums] = {}
#      parsed_artist[:wiki_url] = artist_wiki_url
#      parsed_artists[artist_name] = parsed_artist
#    end
#    if parsed_artists[artist_name][:albums][album_name].nil?
#      parsed_album = {}
#      parsed_album[:wiki_url] = album_wiki_url
#      parsed_album[:sales] = {}
#      parsed_artists[artist_name][:albums][album_name] = parsed_album
#    end
#    parsed_artists[artist_name][:albums][album_name][:sales][current_year] = album_sales
#  end
#end
#
#puts "Adding the following data to the database: \n"
#parsed_artists.sort.each do |artist_name, artist_data|
#  puts "#{artist_name} [#{artist_data[:wiki_url]}]"
#  current_artist = Artist.find_or_create_by_name(:name => artist_name, :wikipedia_url => artist_data[:wiki_url], :processed_similar => false, :processed_top_albums => false)
#  artist_data[:albums].sort.each do |album_name, album_data|
#    puts "  #{album_name} [#{album_data[:wiki_url]}]"
#    current_album = Album.find_or_create_by_title(:title => album_name, :wikipedia_url => album_data[:wiki_url], :artist_id => current_artist.id)
#    album_data[:sales].sort.each do |year, sales|
#      soundscan = Soundscan.find(:first, :conditions => { :year => year, :sales => sales, :album_id => current_album.id })
#      if soundscan.nil?
#        Soundscan.create(:year => year, :sales => sales, :album_id => current_album.id)
#      end
#      sales_string = sales.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
#      puts "    #{year}: $#{sales_string}"
#    end
#  end
#  puts
#end
#
#require 'cgi'
#
#
#all_artists = Artist.all
#
#all_artists.each do |artist|
#  next if artist[:name] == 'Various Artists'
#  
#  current_last_fm_artist = last.artist_info artist[:name]
#    #add_column :artists, :mbid, :string
#  artist.mbid = current_last_fm_artist['mbid']
#    #add_column :artists, :lastfm_url, :string
#  artist.lastfm_url = current_last_fm_artist['url']
#    #similar{ artist }[]{ name url image[] }
#    #add_column :artists, :similar_artists_data, :string
#  artist.similar_artists_data = current_last_fm_artist['similar']['artist'] unless current_last_fm_artist['similar'].nil?
#    #images[]
#    #add_column :artists, :images_data, :string
#  artist.images_data = current_last_fm_artist['image']
#    #tags{ tag }[]{ name url }
#    #add_column :artists, :tags_data, :string
#  artist.tags_data = current_last_fm_artist['tags']['tag'] unless current_last_fm_artist['tags'].nil?
#    #bio{ published summary content }
#    #add_column :artists, :bio_data, :string
#  artist.bio_data = current_last_fm_artist['bio']
#  
#  if artist.save
#    puts "Updated #{artist[:name]}"
#  else
#    puts "Error Updating #{artist[:name]}"
#  end
#end
#
#all_albums = Album.find(:all, :include => :artist)
#
#all_albums.each do |album|
#  current_last_fm_album = last.album_info( CGI.unescapeHTML(album.artist.name), CGI.unescapeHTML(album.title) )
#    #add_column :albums, :mbid, :string
#  album.mbid = current_last_fm_album['mbid']
#    #add_column :albums, :release_date, :datetime
#  album.release_date = current_last_fm_album['releasedate'].strip! unless current_last_fm_album['releasedate'].nil?
#    #add_column :albums, :lastfm_url, :string
#  album.lastfm_url = current_last_fm_album['url']
#    #ad_column :albums, :top_tags_data, :string
#  album.top_tags_data = current_last_fm_album['toptags']['tag'] unless current_last_fm_album['toptags'].nil?
#    #add_column :albums, :images_data, :string
#  album.images_data = current_last_fm_album['image']
#    #add_column :albums, :description_data, :string
#  album.description_data = current_last_fm_album['wiki']
#      
#  if album.save
#    puts "Updated #{album.title}"
#  else
#    puts "Error Updating #{album.title}"
#  end
#end


#all_artists = Artist.all(:conditions => { :processed_similar => false })
#
#new_count = 0
#
#all_artists.each do |source_artist|
#  next if source_artist.name == 'Various Artists'
#  puts "Mining #{source_artist.name} for similars:"
#  source_artist.similar_artists_data.each do |sim|
#    begin
#      current_last_fm_artist = last.artist_info sim["name"]
#    rescue
#      puts "Error querying last.fm for #{sim["name"]}. Trying again..."
#      current_last_fm_artist = last.artist_info sim["name"]
#    end
#    artist = Artist.find(:first, :conditions => {:name => sim["name"]})
#    if artist.nil?
#      new_count += 1
#      artist = Artist.new(:name => sim["name"], :processed_similar => false, :processed_top_albums => false)
#      artist.mbid = current_last_fm_artist['mbid']
#      artist.lastfm_url = current_last_fm_artist['url']
#      artist.similar_artists_data = current_last_fm_artist['similar']['artist'] unless current_last_fm_artist['similar'].nil?
#      artist.images_data = current_last_fm_artist['image']
#      artist.tags_data = current_last_fm_artist['tags']['tag'] unless current_last_fm_artist['tags'].nil?
#      artist.bio_data = current_last_fm_artist['bio']
#      
#      if artist.save
#        puts "  Added #{sim["name"]} - Listeners: #{current_last_fm_artist["stats"]["listeners"]}"
#      else
#        puts "  Error Adding #{artist[:name]}"
#      end
#    else
#      puts "  Skipping #{sim["name"]}"
#    end
#  end
#  source_artist.processed_similar = true
#  source_artist.save
#end
#
#puts "Added #{new_count} new artists."