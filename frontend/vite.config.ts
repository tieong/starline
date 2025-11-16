import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { reactGrab } from './vite-plugin-react-grab'
import path from 'path'

export default defineConfig({
  plugins: [reactGrab(), react()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
  server: {
    watch: {
      usePolling: true,
    },
    host: true,
  },
})
