// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2024-04-03',
  devtools: { enabled: true },
  experimental: { appManifest: false },
  css: ['~/styles/app.css'],
  postcss: {
    plugins: {
      tailwindcss: {},
      autoprefixer: {},
    },
  },

  runtimeConfig: {
    public: {
      supabaseUrl: process.env.SUPABASE_URL || 'https://feavdvsmfihynwtgxmxr.supabase.co',
      supabaseAnonKey: process.env.SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZlYXZkdnNtZmloeW53dGd4bXhyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc1ODg5MzMsImV4cCI6MjA3MzE2NDkzM30.BKFreBIPiyaoB_t8MPfkMHM2o32oRqytlWd-L1-2qr0',
      monnifyApiKey: process.env.MONNIFY_API_KEY || '',
      monnifyContractCode: process.env.MONNIFY_CONTRACT_CODE || ''
    }
  },

  app: {
    head: {
      title: "CIRKU",
      htmlAttrs: { lang: "en" },
      link: [{ rel: "icon", type: "image/x-icon", href: "/favicon.ico" }],
      script: [
        {
          src: "https://sdk.monnify.com/plugin/monnify.js",
          type: "text/javascript",
        },
      ],
      meta: [
        {
          hid: "description",
          name: "description",
          content:
            "CIRKU",
        },
        {
          hid: "viewport",
          name: "viewport",
          content: "width=device-width,initial-scale=1.0",
        },
      ],
    },
  },

  modules: ["@pinia/nuxt"],
})