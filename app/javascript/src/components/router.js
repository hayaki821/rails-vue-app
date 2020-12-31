import { createRouter, createWebHistory } from 'vue-router'
import Index from '@/components/pages/index.vue'
import About from '@/components/pages/about.vue'
import Contact from '@/components/pages/contact.vue'

const routerHistory = createWebHistory()

const routes = [
    { path: '/', component: Index },
    { path: '/about', component: About },
    { path: '/contact', component: Contact },
  ];

  const router = createRouter({
    history: routerHistory,
    routes,
  });
  
  export default router;