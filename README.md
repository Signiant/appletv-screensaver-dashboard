# appletv-screensaver-dashboard
Use the screensaver on the appleTV to display dashboards.  The idea was heavily borrowed from this [excellent blog post](http://tech.taskrabbit.com/blog/2015/02/16/apple-tv-dashboard) (but modified to use the photos app, python and bash)

# Prerequisites
To run this you'll need a mac hooked up to the same icloud account as your appleTV(s).  You'll also need python on the mac and the photos app (included with OS-X).

# Configuration
* Install [Firefox](https://www.mozilla.org/en-US/firefox/new/)
* Install pip `sudo easy_install pip`
* Install the required modules `sudo pip install pyyaml selenium`
* Grab the [geckodriver](https://github.com/mozilla/geckodriver/releases) for selenium and copy it to /usr/local/bin
* Create a YAML file for the URLs you want to screenshot and put on the appleTV screensaver.  A sample is included in sample_config

# Photos Base Configuration
In the photos app, add an image that will be there all the time.  The appleTV screensaver will revert from icloud to pretty pics if you remove all images from the photo stream.  So you'll need an image that is constantly in your icloud photo stream.  Once you've added your permanent image, add 1 more "sacrifical" image.  The reaason for this one is the applescript in this project will remove the last imported items each time it runs to "clear out" the stream.

All of this is because for the photos API in applescript, there's no way to remove a single photo (yeah, this makes me sad)

# Running

There's a small bash script included that will run the python script to create the screenshots and put them in a folder.  It will then invoke the applescript to launch the photos app and import the newly screenshotted pages.  This script can be run from cron.

# Gotchas
Running applescript requires the caller to be enabled in accessability under system settings -> Security and privacy. The problem is you can't add cron in there until you've tried to run it once.  So add a low frequency cron and then go add cron to the list here.  Same for Terminal if you want to run the script from the terminal prompt.
