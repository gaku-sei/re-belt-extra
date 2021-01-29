module.exports = {
  rootDir: "tests",
  testRegex: "\\/tests\\/.*_Test\\.js?$",
  transformIgnorePatterns: ["/node_modules/(?!bs-*|re-*).+\\.js$"],
  transform: {
    "^.+\\.(js)$": "babel-jest",
  },
};
