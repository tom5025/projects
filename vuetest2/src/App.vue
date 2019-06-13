<template>
  <div>
    <v-toolbar>
      <v-toolbar-side-icon></v-toolbar-side-icon>
      <v-toolbar-title>Beer view app</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items class="hidden-sm-and-down">
        <v-btn flat><router-link to="/">Home
      </router-link></v-btn>      
      </v-toolbar-items>
    </v-toolbar>    
    <router-view />
  </div>
</template>