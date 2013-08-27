# The API only supports a basic set of functionality,
# basic playback control with:
#        play, pause, playpause, previous track,
#        next track methods, name, artist, album,
#        duration, artwork and rdio url of the current track.
require_relative 'rdio'
require_relative 'rdio_consumer_credentials'

module  Player
   class << self
      %w[play pause next_track previous_track].each do |action|
         define_method action do
            exec_command "osascript -e 'tell app \"Rdio\" to  #{action.gsub('_',' ')}'"
         end
      end

      def play_song(song="")
         exec_command "osascript -e 'tell app \"Rdio\" to play source \"#{song}\"'"
      end

      def exec_command kommand=""
         `#{kommand}`
      end

      def song_name
         exec_command "osascript -e 'tell app \"Rdio\" to get the name of the current track'"
      end

      def artist_name
         exec_command "osascript -e 'tell app \"Rdio\" to get the artist of the current track'"
      end

      def song_info
         s_name = song_name.chomp
         a_name = artist_name.chomp
         if s_name.empty?
            return ""
         else
            return "======\nArtist: #{a_name}\n  Song: #{s_name}\n======\n"
         end
      end

      def is_open?
          result = exec_command "osascript -e 'tell application \"System Events\" to (name of processes) contains \"Rdio\"'"
          return result == "true" ? true : false
      end

      def play_random_song
         rdio = Rdio.new([RDIO_CONSUMER_KEY, RDIO_CONSUMER_SECRET], ["5fdqjx4vp4tfpy2j75amgcmfhuxxvemuwpswtbfpppvx6wad9rtx3mrxmww3dzfn", "Abz65daMDgvf"])
         rdio_response = rdio.call("getHeavyRotation")
         # Get a random artist
         artists = rdio_response["result"]
         random_artist = rand(0...artists.size)
         artist = artists[random_artist]
         # Get random track from artist
         random_track = rand(0...artist["length"])
         track_key = artist["trackKeys"][random_track]

         play_song(track_key)
      end

      def search params={}
         text= params[:song]
         play= params[:play]
         with_artist = false


         if params[:artist].empty?
            method = "searchSuggestions"
         else
            with_artist = true
            method = "search"
            text += " #{params[:artist]}"
         end

         rdio = Rdio.new([RDIO_CONSUMER_KEY, RDIO_CONSUMER_SECRET], RDIO_TOKENS)
         rdio_response = rdio.call(method, query: text, types: "Track", extras: "name, albumArtist, type")

         if with_artist
            songs = rdio_response["result"]["results"]
         else
            songs = rdio_response["result"]
         end

         response = ""

         if play.empty?
            songs.each_with_index do |song,index|
               next if song["type"] != "t"
               response += "=====#{index}=====\n"
               response += "name   : #{song["name"]}\n"
               response += "artist : #{song["albumArtist"]}\n"
            end
         else
            songs.each_with_index do |song,index|
               if index == play.to_i
                  play_song song["key"].chomp
                  sleep 2.5
                  response = "Now playing: #{song_name.chomp} - #{artist_name.chomp}"
               end
            end
         end
         response+"\n"
      end
   end
end
