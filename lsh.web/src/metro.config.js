const { getDefaultConfig } = require("expo/metro-config");
const { withNativeWind } = require("nativewind/metro");

const config = getDefaultConfig(__dirname);

// Required for web — already in your config
config.resolver.sourceExts.push("mjs");

// Add this: tell Metro to treat .mjs as ESM
config.resolver.unstable_enablePackageExports = true;

module.exports = withNativeWind(config, { input: "./global.css" });