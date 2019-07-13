import Vuetify from 'vuetify';
import './plugins/vuetify';
import Vue from 'vue';
import App from './App.vue';
import router from './router';
import store from './store';
import 'vuetify/dist/vuetify.min.css'; // Ensure you are using css-loader
import newBrandServiceMock from './services/BrandServiceMock';

Vue.use(Vuetify,
  {
    theme: {
      primary: '#3f51b5',
      secondary: '#b0bec5',
      accent: '#8c9eff',
      error: '#b71c1c',
    },
  });
Vue.config.productionTip = false;
const brandSvc = newBrandServiceMock();

new Vue({
  router,
  store,
  brandSvc,
  render: h => h(App),
}).$mount('#app');
