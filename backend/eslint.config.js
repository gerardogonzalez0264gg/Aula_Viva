// Reglas para revisar que el código esté ordenado y sin errores tontos
const js = require("@eslint/js");
const globals = require("globals");

module.exports = [
  js.configs.recommended,
  {
    files: ["**/*.js"],
    languageOptions: {
      sourceType: "commonjs",
      globals: { ...globals.node },
    },
  },
  { ignores: ["node_modules/", "coverage/"] },
];
