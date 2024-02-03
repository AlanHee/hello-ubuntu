#!/bin/bash

sudo snap install flutter --classic
flutter
wget http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
tar xvzf android-sdk_r24.4.1-linux.tgz
mv android-sdk-linux /usr/local
flutter config --android-sdk=/usr/local/android-sdk-linux/
echo "flutter && android-sdk installed"
