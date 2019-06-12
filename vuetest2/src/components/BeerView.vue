import BeerService from '../services/BeerService'

<template>
  <div class="BeerView">
      <div>Beer list</div>
      <v-data-table
              :headers='headers'
              :items='items'
              :length='pages'
              :search='search'
              :pagination.sync='pagination'
              :total-items='totalItemCount'
              class='elevation-1'
      >
          <template slot='items' slot-scope='props'>          
              <td class='text-xs-right'>{{ props.item.name }}</td>            
          </template>
      </v-data-table>
  </div>
  </template>
<script>
  export default{
      name:"BeerView",
      data: () => ({
        async mounted () {
          const rowsPerPage = this.pagination.rowsPerPage
          const skip = (this.pagination.page - 1) * rowsPerPage
          let svc = new BeerService();
          const res = await svc.getBeers(skip,rowsPerPage,"Extra Malt", 7);
          this.items = res.data.data;
        },        
        search: '',
        // totalItems: 0,
        items: [],
        pagination: {
          sortBy: 'name'
        },
        headers: [   
          { text: 'Name', value: 'name' },      
        ]     
      })
  }
</script>