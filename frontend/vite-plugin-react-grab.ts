import { Plugin } from 'vite';

/**
 * Plugin Vite personnalisé pour react-grab
 * Injecte automatiquement le script react-grab en mode développement
 */
export function reactGrab(): Plugin {
  return {
    name: 'vite-plugin-react-grab',
    transformIndexHtml(html) {
      // Injecter le script uniquement en mode développement
      if (process.env.NODE_ENV !== 'production') {
        return {
          html,
          tags: [
            {
              tag: 'script',
              attrs: {
                src: '//unpkg.com/react-grab/dist/index.global.js',
                crossorigin: 'anonymous',
                'data-enabled': 'true',
              },
              injectTo: 'head',
            },
          ],
        };
      }
      return html;
    },
  };
}
