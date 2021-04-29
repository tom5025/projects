<template>
    <form id="app"
    @submit="checkForm"
    action=""
    method="post">
      <p v-if="errors.length">
          <b>Veuillez corriger les erreurs suivantes</b>
          <ul>
             <li v-for="error in errors" :key="error">{{ error }}</li>
          </ul>
      </p>    

    <p>
        <label for="name">Name</label>
        <input
        id="name"
        v-model="name"
        type="text"
        name="name"
        >
    </p>


    </form>
</template>

<script>
    export default{
        data:
        {
            errors:[],
            
        },
        computed:
        {
            machin()
            {
                
            }
        }
    }
</script>