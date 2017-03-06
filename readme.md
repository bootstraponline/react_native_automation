## Debugging

- Cmd + D - Open debug menu, enable debugging JS remotely
- Cmd + Opt + J - Open chrome dev tools `http://localhost:8081/debugger-ui`

## Getting started

```
brew update
brew install yarn
brew install node
brew install watchman
npm install -g react-native-cli
react-native init button
```

```
cd ios
gem install earlgrey
earlgrey -t buttonTests # requires shared scheme
carthage update EarlGrey --platform ios
```

## Install iOS deps

```bash
#!/bin/bash
set -euxo pipefail

cd button
yarn
cd ios
carthage update EarlGrey --platform ios
```

## Running the apps

```
To run your app on iOS:
   react-native run-ios
   - or -
   Open ios/button.xcodeproj in Xcode
   Hit the Run button

To run your app on Android:
   Have an Android emulator running (quickest way to get started), or a device connected
   react-native run-android
```