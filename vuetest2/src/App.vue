<template>
  <div>
    <v-toolbar>
      <v-toolbar-side-icon></v-toolbar-side-icon>
      <v-toolbar-title>Beer view app</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items class="hidden-sm-and-down">
        <router-link to="/"><v-btn small><span>Home</span></v-btn>      
      </router-link>
      </v-toolbar-items>
    </v-toolbar>    
    <router-view />
  </div>
</template>