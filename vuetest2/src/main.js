// Import Vue
import Vue from 'vue';
import VueRouter from 'vue-router';

// Import Vue App, routes, store
import App from './App';
import routes from './routes';
import Vuetify, {
    VApp, // required
    VNavigationDrawer,
    VToolbar,
    // eslint-disable-next-line sort-imports
    VFadeTransition,
    VDataTable
} from 'vuetify/lib';
import { Ripple } from 'vuetify/lib/directives';

Vue.use(Vuetify, {
    components: {
        VApp,
        VNavigationDrawer,        
        VFooter,
        VToolbar,
        VFadeTransition
    }
    ,
    directives: {
        Ripple
    }
});

Vue.use(VueRouter);
    

// Configure router
const router = new VueRouter({
    routes,
    linkActiveClass: 'active',
    mode: 'history'
});

new Vue({
    el: '#app',
    render: h => h(App),
    router
});
