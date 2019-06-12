<template>
<div class="row">      
    <div class="col-md-4 col-lg4" v-for="(data,index) in products" :key="index">        
        <h3>{{data.productTitle}}</h3>      
    </div>    
</div>
</template>
<script>
export default {
  name: "testView",
  data() {
    return {
      title: "testView",
      products: [
        {
          productTitle: "ABCN",
          // image: require("../assets/images/product1.png"),
          productId: 1
        },
        {
          productTitle: "KARMA",
          //image: require("../assets/images/product2.png"),
          productId: 2
        },    
      ]
    };
  }
};
</script>