#!/bin/bash
dart pub global activate dart_frog_cli
echo "export PATH="$PATH":"$HOME/.pub-cache/bin"" >>~/.profile
