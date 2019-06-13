<template>
  <div class="BeerView">
      <div>Beer list</div>
      <v-switch
        v-model="switchOnlyAboveSevenPct"
        :label="`Only 7% volume`"        
      >
      </v-switch>
      <v-data-table
              :headers='headers'
              :items='items'
              :length='pages'              
              :pagination.sync='pagination'              
              :total-items="totalItemCount"
              class='elevation-1'
      >
          <template slot='items' slot-scope='props'>          
              <td class='text-xs-left'>{{ props.item.name }}</td> 
              <td class='text-xs-left'>{{ props.item.abv }}</td>
              <td class='text-xs-left'>{{ props.item.tagline}}</td> 
              <td><img class='row col-md-1 thumbnail img-responsive img-fluid' :src='props.item.image_url' /></td>             
          </template>
      </v-data-table>
  </div>
  </template>
<script src="./BeerView.js">
  
</script>