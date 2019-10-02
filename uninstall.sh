#!/bin/bash

launchctl unload ~/Library/LaunchAgents/LocationChanger.plist
sudo rm ~/Library/LaunchAgents/LocationChanger.plist
sudo rm /usr/local/bin/locationchanger
