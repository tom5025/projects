<template>
  <v-container>
    <v-layout>
      <v-flex xs1 v-for="brand in brandList" :key="brand">
        {{ brand }}
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
  export default {
    created()
    {
      console.log(this.$brandSvc !== null);
      this.brandList = this.$brandSvc.getBrands();
    },
    data: () =>
    ({
      brandList: []
    })
  }
</script>

<style>
</style>
