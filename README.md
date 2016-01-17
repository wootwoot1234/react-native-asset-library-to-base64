# react-native-asset-library-to-base64
A React Native Module that takes an image's asset-library:// uri and returns base64:

## Install

### iOS
1. `npm install react-native-asset-library-to-base64@latest --save`
2. In the XCode's "Project navigator", right click on your project's Libraries folder ➜ `Add Files to <...>`
3. Go to `node_modules` ➜ `react-native-asset-library-to-base64` ➜ `ios` ➜ select `AssetLibraryToBase64.m`
4. Make sure `AssetLibraryToBase64.m` is listed under 'Compile Sources' in your project's 'Build Phases' tab
5. Compile and have fun

## Usage
1. In your React Native javascript code, bring in the native module:

  ```javascript
var ReadImageData = require('NativeModules').ReadImageData;
  ```
2. Use it like so:

  ```javascript
// uri is link to asset-library://
ReadImageData.readImage(uri, (imageBase64) => {
  console.log(imageBase64);
});
  ```
