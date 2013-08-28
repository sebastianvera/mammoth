rdio_server_ip="127.0.0.1:4567"

play() {
   if [ "$1" = "random" ]; then
      if ! curl -XPOST "http://$rdio_server_ip/random" 2>/dev/null ; then
        echo "Sinatra app is off"
      fi
   elif [[ -n $1 ]]; then
      search "$@"
   elif ! curl -XPOST "http://$rdio_server_ip/play" 2>/dev/null ; then
      echo "Sinatra app is off"
   fi
}
pause() {
   if ! curl -XPOST "http://$rdio_server_ip/pause" 2>/dev/null ; then
      echo "Sinatra app is off"
   fi
}
next() {
   if ! curl -XPOST "http://$rdio_server_ip/next" 2>/dev/null ; then
      echo "Sinatra app is off"
   fi
}
previous() {
   if ! curl -XPOST "http://$rdio_server_ip/previous" 2>/dev/null ; then
      echo "Sinatra app is off"
   fi
}
song() {
   if ! curl -XPOST "http://$rdio_server_ip/song" 2>/dev/null ; then
      echo "Sinatra app is off"
   fi
}
search() {
   if echo "$1" | grep -v "-" > /dev/null; then
      if [ -n $1 ]; then
         text=$1
         shift
         if [ -n "$(echo $1 | grep '^-')" ]; then
            case $1 in
               -p|--play)  local play=$2
                                   shift;;
                * ) echo 'Use search [-s | --song] [-a | --artist] [-c] args...';;
            esac
         fi
         if ! curl -XPOST "http://$rdio_server_ip/search" -d "song="  -d "artist=$text" -d "play=$play" ; then
            echo "Sinatra app is off"
         fi
      else
         echo "Use search [song_name] or [-s | --song] [-a | --artist] [-c] args..."
      fi
   else
      local artist
      while [ -n "$(echo $1 | grep '^-')" ]
      do
         case $1 in
            -s|--song) local song=$2
                                shift;;
            -a|--artist) local artist=$2
                                shift;;
            -p|--play)  local play=$2
                                shift;;
             * ) echo 'Use search [-s | --song] [-a | --artist] [-c] args...'
                  exit 1;;
         esac
         shift
         done
         if ! curl -XPOST "http://$rdio_server_ip/search" -d "song=$song"  -d "artist=$artist" -d "play=$play"; then
            echo "Sinatra app is off"
         fi
   fi
}
