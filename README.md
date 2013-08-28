Mammoth
=======

Mammoth allows us to control Rdio's native application from the terminal, on any computer in the LAN.

## What do we need?

* Rdio native application.
* Rdio API Keys from [developer site][rdio_dev].
* Save Rdio Api Keys in ``` rdio_consumer_credentials.rb ```.
* Run ``` ruby setup.rb ``` - for getting Rdio oauth tokens (First time only).
* Run ``` ruby web.rb ``` - this handles terminal's requests (Run every time you want to use mammoth).
* Add mammoth zsh plugin or add the content of mammoth.plugin.zsh to your ```.bashrc``` or ```.bash_profile```.

Now you are ready to go!

## Usage

After adding the mammoth plugin, you now can use these functions from your terminal:

- play
- pause
- next
- previous
- song

If you are not running ```web.rb```, each command will return: ```Sinatra app is off```.

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


