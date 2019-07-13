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
    data: () =>
    ({
      brandList: this.$brandSvc.getBrands()
    })
  }
</script>

<style>
</style>
