<template>
  <v-layout>
    <v-flex xs12 sm6 offset-sm3>
      <v-card>
        <!-- <v-card-actions>
          <v-select v-model="size" :items="items" label="Size"></v-select>
          <v-spacer></v-spacer>
        </v-card-actions> -->
        <v-container v-bind="{ [`grid-list-${size}`]: true }" fluid>
          <v-layout row wrap>
            <v-flex
              v-for="brand in brandList"
              :key="brand"
              xs4
            >
              <v-card tile>
                {{brand}}
                <!-- <v-img
                  :src="`https://unsplash.it/150/300?image=${Math.floor(Math.random() * 100) + 1}`"
                  height="150px"
                ></v-img> -->
              </v-card>
            </v-flex>
          </v-layout>
        </v-container>
      </v-card>
    </v-flex>
  </v-layout>
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
