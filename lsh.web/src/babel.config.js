module.exports = {
  presets: [
    [
      "babel-preset-expo",
      {
        jsxImportSource: "nativewind",
        // babel-preset-expo reads options.web and merges it when platform === 'web'.
        // worklets: false suppresses the auto-injected react-native-worklets/plugin,
        // which injects import.meta — syntax Metro web cannot handle.
        web: {
          worklets: false,
          reanimated: false,
          // Zustand (and other ESM packages) use import.meta.env.MODE.
          // Metro web cannot parse import.meta — this transforms it to
          // globalThis.__ExpoImportMetaRegistry so the bundle runs.
          unstable_transformImportMeta: true,
        },
      },
    ],
  ],
};
