# Voice Bravia [Experimental]

This small project can be used for controlling your Bravia TV with your voice via Google Assistant or Siri.

## Prerequisites

In order to use `Voice Bravia`, you need the following setup

- Sony Bravia TV
- local server with Ruby
- wakeonlan script
- HomePod & Shortcuts or Google Home & IFTTT

Your Sony Bravia TV, your local server and your HomePod or Google Home must be in the same local network.

## Sony Bravia TV

First enable sending commands over IP on your Bravia TV.  

1. Go to `Settings` → `Network` → `Home Network Setup` → `IP Control`.
2. Set `Authentication` to `Normal and Pre-Shared Key`.
3. Set your `Pre-Shared Key` to `0000`. If you choose anything else, you need to change the PSK request in the file `irrc_command.rb`.

Now you can communicate with your Bravia TV over your local network.

## WakeOnLan Script

In order to turn on your TV there is additional software necessary. You can download `wakeonlan` script [here](http://github.com/jpoliv/wakeonlan) and place the script under a `vendor` directory inside `voice-bravia`.

## Sinatra App

All settings have to be configured in `app.rb`.

1. Configure the Bravia TV settings; you have to supply `ip address` and `mac address` of your TV.
2. Register the commands you want to use for your TV. The actions defined on the right side are triggered by the registered key word.
3. Register your voice commands. On the left side you can choose the trigger voice command, on the right side the corresponding Bravia command.
4. Run the Sinatra app.

__Note:__ Your local server needs to configured such, that the outside world can talk to your Sinatra app.

The last step is to trigger a web request when you give a voice command to your assistant.

## Google Home & IFTTT

When using Google Home, you can accomplish the last step by using a service like IFTTT. It offers recipes for `Google Assistant` and `Webhooks`. In IFTTT you choose a trigger command like `Bravia $`. The `$` is a placeholder for your voice command.
After that you have to supply the URL to your service. Make sure that the voice command will be added to your URL; it should look something like this

```
https://your-domain-or-dns-service/tv/<<<{{TextField}}>>>
```

## HomePod & Shortcuts App

When using a HomePod, you can trigger a command via Shortcuts App of one of your iOS devices. Make sure to set up a voice trigger (dictate text), add the command to your URL like

```
https://your-domain-or-dns-service/tv/[TextParameter]
```

and call the URL
