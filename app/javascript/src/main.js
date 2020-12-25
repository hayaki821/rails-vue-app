import { createApp } from 'vue'
import Hello from '@/components/Hello.vue'

export default () => {
    document.addEventListener('DOMContentLoaded', () => {
        const app = createApp(Hello)
        app.mount('#vue-app')
    })
}