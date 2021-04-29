<template>
  <v-app>
    <v-toolbar app>
      <v-toolbar-title class="headline text-uppercase">
        <span>Car</span>
        <span class="font-weight-light">Tutorial</span>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn
        flat
        href="https://github.com/vuetifyjs/vuetify/releases/latest"
        target="_blank"
      >
        <span class="mr-2">Latest Release</span>
      </v-btn>
    </v-toolbar>

    <v-content>
      <BrandList/>
    </v-content>
  </v-app>
</template>

<script>
import BrandList from './components/BrandList'

export default {
  name: 'App',
  components: {
    BrandList
  },
  data () {
    return {
      //
    }
  }
}
</script>
