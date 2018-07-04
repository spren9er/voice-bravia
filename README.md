# Voice Bravia [Experimental]

This small project can be used for controlling your Bravia TV with your voice via Google Home.

## Prerequisites

In order to use `Voice Bravia`, you need the following setup

- Google Home
- Sony Bravia TV
- local server with Ruby
- IFTTT account
- wakeonlan script

Your Google Home, Sony Bravia TV and your local server must be in the same local network.

## Sony Bravia TV

First enable sending commands over IP on your Bravia TV.  

1. Go to `Settings` → `Network` → `Home Network Setup` → `IP Control`.
2. Set `Authentication` to `Normal and Pre-Shared Key`.
3. Set your `Pre-Shared Key` to `0000`. If you choose anything else, you need to change the PSK request in the file `irrc_command.rb`.

Now you can communicate with your Bravia TV over your local network.

## WakeOnLan Script

In order to turn on your TV there is an additional software necessary. You can download `wakeonlan` script [here](http://github.com/jpoliv/wakeonlan) and place the script under a `vendor` directory inside `voice-bravia`.

## Sinatra App

1. Configure the Bravia settings in `app.rb`. You have to supply `ip address` and `mac address` of your TV.
2. Register the commands you want to use for your TV. The actions defined on the right side are triggered by the registered key word.
3. Register your voice commands. On the left side you can choose the trigger voice command (use the same language which is configured in your Google Home), on the right side the corresponding Bravia command.
4. Run the Sinatra app.

## IFTTT

The last step is to trigger a web request when you give a voice command to your Google Home.
You can accomplish this by using a service like IFTTT. It offers recipes for `Google Assistant` and `Webhooks`. In IFTTT you choose a trigger command like `Bravia $`. The `$` is a placeholder for your voice command.
Then you have to supply the URL to your service. Make sure that your voice command will be added to your URL.
The URL should look something like this

ˋˋˋ
https://your-domain.com/tv/<<<{{TextField}}>>>
ˋˋˋ

__Note__ Your local server needs to configured such, that the outside world can talk to your Sinatra app.
