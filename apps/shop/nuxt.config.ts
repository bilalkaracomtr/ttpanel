import { config } from "dotenv";
import { resolve } from "path";

config({
  path: resolve(__dirname, "../../config/env/.env.shop"),
});

export default defineNuxtConfig({
  devServer: {
    port: parseInt(process.env.NITRO_PORT || "3002"),
    host: process.env.NITRO_HOST || "0.0.0.0",
  },
  runtimeConfig: {
    public: {
      apiBaseUrl: process.env.API_BASE_URL || "http://localhost:3000",
      gaId: process.env.GA_ID || "",
      fbPixelId: process.env.FB_PIXEL_ID || "",
    },
  },
});
