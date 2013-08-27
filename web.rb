require 'sinatra'
require_relative 'player'

get // do
   "Holi ! :)"
end

post '/pause' do
   Player.pause
end

post '/play' do
   Player.play
end

post '/next' do
   Player.next_track
   sleep 1.5
   Player.song_info
end

post '/previous' do
   Player.previous_track
   sleep 1.5
   Player.song_info
end

post '/song' do
   song = Player.song_info
   song = song.empty? ? "No song avalaible\n" : song
   song
end

post '/search' do
   Player.search(params)
end

post '/random' do
   Player.play_random_song
   sleep 1.5
   Player.song_info
end
