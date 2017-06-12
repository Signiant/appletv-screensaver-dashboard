#!/bin/bash

pkill -9 photo
pkill -9 com.apple.CloudPhotosConfiguration

echo Capturing dashboard screen shots..
/usr/bin/python /Users/devops/Documents/apple_tv_dashboards/take-shots.py -c /Users/devops/Documents/apple_tv_dashboards/config.yaml

echo "importing dashboards into photos app..."
/usr/bin/osascript /Users/devops/Documents/apple_tv_dashboards/dashboard_photos.scpt
