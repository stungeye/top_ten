require 'glutton_lastfm'
require 'pp'

namespace :scrape do
    WORKING_DIR = File.dirname(__FILE__)
    last = GluttonLastfm.new '923a366899eebed73ba992fff9be063e'
    
    task :soundscan_albums => :environment do
        require 'nokogiri'
        top_albums = Nokogiri::HTML(File.new(WORKING_DIR + '/seeds.html'), nil, 'UTF-8')
        
        parsed_artists = {}
        
        list_years = top_albums.xpath('//div')
        
        list_years.each do |list_year|
          current_year = list_year.xpath('./h3')[0].inner_html
          albums = list_year.xpath('./ol/li')
          albums.each do |album|
            
            album_node_string = album.inner_html
            album_sales       = album_node_string.split('~')[1].strip.gsub(',','').to_i
            
            album_link        = album.xpath('./i/a')[0]
            album_name        = album_link.child.to_xhtml(:encoding => 'UTF-8')
            album_wiki_url    = album_link['href']
            
            artist_link       = album.xpath('./a')[0]
            artist_name       = artist_link.child.to_xhtml(:encoding => 'UTF-8')
            artist_wiki_url   = artist_link['href']
            
            if parsed_artists[artist_name].nil?
              parsed_artist = {}
              parsed_artist[:albums] = {}
              parsed_artist[:wiki_url] = artist_wiki_url
              parsed_artists[artist_name] = parsed_artist
            end
            if parsed_artists[artist_name][:albums][album_name].nil?
              parsed_album = {}
              parsed_album[:wiki_url] = album_wiki_url
              parsed_album[:sales] = {}
              parsed_artists[artist_name][:albums][album_name] = parsed_album
            end
            parsed_artists[artist_name][:albums][album_name][:sales][current_year] = album_sales
          end
        end
        
        puts "Adding the following data to the database: \n"
        parsed_artists.sort.each do |artist_name, artist_data|
          puts "#{artist_name} [#{artist_data[:wiki_url]}]"
          current_artist = Artist.find_or_create_by_name(:name => artist_name, :wikipedia_url => artist_data[:wiki_url], :processed_similar => false, :processed_top_albums => false)
          artist_data[:albums].sort.each do |album_name, album_data|
            puts "  #{album_name} [#{album_data[:wiki_url]}]"
            current_album = Album.find_or_create_by_title(:title => album_name, :wikipedia_url => album_data[:wiki_url], :artist_id => current_artist.id)
            album_data[:sales].sort.each do |year, sales|
              soundscan = Soundscan.find(:first, :conditions => { :year => year, :sales => sales, :album_id => current_album.id })
              if soundscan.nil?
                Soundscan.create(:year => year, :sales => sales, :album_id => current_album.id)
              end
              sales_string = sales.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
              puts "    #{year}: $#{sales_string}"
            end
          end
          puts
        end
    end
    
    task :similar_artists => :environment do
        all_artists = Artist.all(:conditions => { :processed_similar => false })
        new_count = 0
        all_artists.each do |source_artist|
          next if source_artist.name == 'Various Artists'
          puts "Mining #{source_artist.name} for similars:"
          pp source_artist.similar_artists_data
          source_artist.similar_artists_data.each do |sim|
            begin
              current_last_fm_artist = last.artist_info sim["name"]
            rescue
              puts "Error querying last.fm for #{sim["name"]}. Trying again..."
              current_last_fm_artist = last.artist_info sim["name"]
            end
            artist = Artist.find(:first, :conditions => ["name like ?", sim['name']])
            if artist.nil?
              new_count += 1
              artist = Artist.new(:name => sim["name"], :processed_similar => false, :processed_top_albums => false)
              artist.mbid = current_last_fm_artist['mbid']
              artist.lastfm_url = current_last_fm_artist['url']
              artist.similar_artists_data = current_last_fm_artist['similar']['artist'] unless current_last_fm_artist['similar'].nil?
              artist.images_data = current_last_fm_artist['image']
              artist.tags_data = current_last_fm_artist['tags']['tag'] unless current_last_fm_artist['tags'].nil?
              artist.bio_data = current_last_fm_artist['bio']
              
              if artist.save
                puts "  Added #{sim["name"]} - Listeners: #{current_last_fm_artist["stats"]["listeners"]}"
              else
                puts "  Error Adding #{artist[:name]}"
              end
            else
              puts "  Skipping #{sim["name"]}"
            end
          end
          source_artist.processed_similar = true
          source_artist.save
        end
        
        puts "Added #{new_count} new artists."
    end
end