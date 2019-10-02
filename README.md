# Mac OSX Wi-Fi Location Changer

* Automatically changes the Mac OSX network location when Wi-Fi connection SSID changes
* Allows having different network settings depending on the Wi-Fi SSID
NEW: * Only change the location in case is not already in use
NEW: * In case of no match, fallback to Automatic (or custom) Location

**Note:** macOS Mojave compatible (tested with 10.14.6)

## Configuration
There are two areas that need to be modified in the locationchanger script, Locations and SSIDs. Both of which are case sensitive. 

### Locations
Edit locationchanger and change/add locations to be set:

**Note:** Ensure you use the exact names as they appear under "Location" in OSX's System Preferences -> Network
or use the CLI:
```bash
scselect
Defined sets include: (* == current set)
 * XXXXXXXX-AAAA-BBBB-CCCC-XXXXXXXXXXX	(Home)
   YYYYYYYY-AAAA-BBBB-CCCC-YYYYYYYYYYY	(Automatic)
```


```bash
# LOCATIONS
# (change the location names to match your MAC configuration, verify the location name withthe scselect command from CLI)
# ============================================================
LOCATION_HOME="Home"
LOCATION_WORK="Work"
LOCATION_AUTOMATIC="Automatic"  #Automatic location in case of no match, should be "Automatic", check with scselect command from CLI

```

### SSIDs
Edit locationchanger and add/edit SSIDs to be detected:

```bash
# SSIDS
# (change the SSID names to match your Wi-Fi networks)
# ============================================================
SSID_HOME="Home-Wifi-SSID"
SSID_WORK="Company-Wifi-SSID"
```

In case you need more SSID/Locations, Add SSIDs -> LOCATIONs and add a mapping to list before the generic cath all * ):

```bash
# SSID -> LOCATION mapping
case $SSID in
	$SSID_HOME )
		if [ $CURRENT_LOCATION != "$LOCATION_HOME" ]
		then
			scselect "$LOCATION_HOME"
			osascript -e 'display notification "Network Location Changed to '$LOCATION_HOME'" with title "Network Location Changed"'
			echo "--> Location changed to: $LOCATION_HOME"
		else
			echo "--> No change, location was already: $LOCATION_HOME"

		fi
	;;
	$SSID_WORK )
		if [ $CURRENT_LOCATION != "$LOCATION_WORK" ]
		then
			scselect "$LOCATION_WORK"
			osascript -e 'display notification "Network Location Changed to '$LOCATION_WORK'" with title "Network Location Changed"'
			echo "--> Location changed to: $LOCATION_WORK"
		else
			echo "--> No change, location was already: $LOCATION_WORK"

		fi
	;;
	* )
		if [ $CURRENT_LOCATION != "$LOCATION_AUTOMATIC" ]
		then
			scselect "$LOCATION_AUTOMATIC"
			osascript -e 'display notification "Network Location Changed to '$LOCATION_AUTOMATIC'" with title "Network Location Changed"'
			echo "--> Location changed to: $LOCATION_AUTOMATIC"
		else
			echo "--> No change, location was already: $LOCATION_AUTOMATIC"
		fi
	;;
esac
```

### MacOS Notifications
The script triggers a MacOS Notification when a Location is changed.

## Installation

### Automated Installation

Execute:
```bash
./install.sh
```

### Manual Installation

Copy these files:
```bash
cp locationchanger /usr/local/bin
cp LocationChanger.plist ~/Library/LaunchAgents/
```
Should you place the locationchanger script to another location, make sure you edit the path in LocationChanger.plist too.

Make locationchanger script executable:
```bash
chmod +x /usr/local/bin/locationchanger
```
Load LocationChanger.plist as a launchd daemon:
```bash
launchctl load ~/Library/LaunchAgents/LocationChanger.plist
```
## Logfile

Logfile location can be adjusted in locationchanger, around line 12:
```bash
exec &>/usr/local/var/log/locationchanger.log
```
See log in action:
```bash
tail -f /usr/local/var/log/locationchanger.log
```
