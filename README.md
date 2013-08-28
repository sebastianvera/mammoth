Mammoth
=======

As developers, we spend a lot of time working in the terminal, 
so if we are sharing music with other developers at the office for example, 
it would be very helpful if each of us could control the music from the terminal.

Mammoth allows us to manage Rdio's native application from the terminal, from any computer in the LAN.

This **only works** on **OS X** systems, is tested on version **10.8.3**.

## What do we need?

1. A Rdio premium account.
2. A Server computer, for handling the terminal's requests and where the music will be played.
3. Computers that will control the music from terminal.

### Server side

The guy who will host the Rdio application and Mammoth server, needs:

* Rdio native application, sure.
* Rdio API Keys from [developer site][rdio_dev].
* Set Rdio API Keys in ``` rdio_consumer_credentials.rb ```.

```ruby
# rdio_consumer_credentials.rb
RDIO_CONSUMER_KEY    = 'foo'
RDIO_CONSUMER_SECRET = 'bar'
RDIO_TOKENS          =  []     # Leave this empty
```

* Run ``` ruby setup.rb ``` - this gets Rdio's oauth tokens **(First time only)**.
* Run ``` ruby web.rb ```   - this handles terminal's requests **(Run every time you want to use mammoth)**.
* Open Rdio.

I recommend to enable **"Autoplay"** function in Rdio App, this will avoid the music to stop playing.

### Client side

User who want to manage the music from his terminal, needs:

1. Set the ```rdio_server_ip``` variable at the mammoth.plugin.zsh, to the server ip (remember adding the ports).
2. If you use zsh, add the mammoth folder containing the zsh plugin to ```~/.oh-my-zsh/custom/plugins/``` and don't forget
  to add ```mammoth``` to the plugins line at ```~/.zshrc```. 
  If you don't use zsh, you can copy mammoth.plugin.zsh to ```~/``` directory and add this line ```source ~/.mammoth.plugin.zsh``` 
  to your ```~/.bashrc``` or ```~/.bash_profile```.
3. Open a new terminal tab.

You are ready to go!

*If you are the server guy, you can also install the zsh plugin and enjoy the ```play random``` function.*

## Usage

After finishing *Client side* step 3, we can use these functions on our terminal:

- play
- pause
- next
- previous
- song

*If you are not running ```web.rb```, each command will return: ```Sinatra app is off```.*

### Play

With this command we can unpause, search and play tracks.

```bash
$ play [query] [-p play]
```

The ```query``` argument contains the key words that you want to search in Rdio, **use quotes** for compounds queries.

```bash
$ play               # this will unpause the player
$ play Artist        # search tracks for "Artist"
... 
$ play Song          # search tracks for "Song"
... 
$ play "Song Artist" # search tracks for "Song Artist", is more likely to find a perfect match
... 
```
This command will return a list of tracks, with id, name and artist:
```bash
$ play "Hello world"
====0====            # id: 0
name  : Hello
artist: Artist.1     
====1====            # id: 1
name  : Hello World          
artist: Artist.2     
    ...
```

The ```-p``` flag, let us specify the song that we want to play, by passing the song id as argument ``` $ play song -p id ``` .

```bash 

$ play "foo ba"     # Search for a song

====0====
name  : foo
artist: bar
====1====
name  : foo
artist: Baz
====2====
name  : foo
artist: Bar

$ play "foo ba" -p 2 # Play the song with id: 2
Now playing: foo - Baz

```

And last but not least, we have the ```play random``` function, that will play a random song
from the heavy rotation list.

```bash
$ play random
... # new song info
```

### Pause
Pause track
```bash
$ pause
```

### Next
Play the next track
```bash
$ next
... # New song info
```
### Previous
Play previous track
```bash
$ previous
... # New song info
```

### Current track info
Display current song info.
```bash
$ song
======
Artist: Hello
  Song: World
======
```

## MISC

If you need to renew your Rdio Application tokens, just use:
```bash
$ ruby setup.rb --renew-tokens
```
And restart your ```web.rb``` server.

## TODO

* Make an easy way to set server ip address in the bash script.
* Windows compatible.
* Linux compatible.

## Author

Sebastian Vera: [@verax_][twitter]

## Credits

Credits to Rdio, that provides the ruby Rdio API Handler, called [rdio-simple for Ruby][rdio].

## Licence

Licensed under [MIT][mit]

[twitter]: http://twitter.com/verax_
[mit]: http://www.opensource.org/licenses/mit-license.php
[rdio]: https://github.com/rdio/rdio-simple/tree/master/ruby
[rdio_dev]: http://developer.rdio.com/


