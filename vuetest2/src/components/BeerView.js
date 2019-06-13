import BeerService from '../services/BeerService';




export default{
      name:"BeerView",
      
      watch:
      {
          async switchOnlyAboveSevenPct(newValue){
            this.pagination.page = 1;
            let svc = new BeerService();
            const res = await svc.getBeers(this.pagination.page,this.pagination.rowsPerPage,this.maltType, this.switchOnlyAboveSevenPct?7:0);          
            this.items = res.data;
          },
          pagination:
          {
            async handler()
            {
              let svc = new BeerService();
              const res = await svc.getBeers(this.pagination.page,this.pagination.rowsPerPage,this.maltType, this.switchOnlyAboveSevenPct?7:0);          
              this.items = res.data;  
            }
          }
      },
      async mounted () {          
          let svc = new BeerService();
          const res = await svc.getBeers(this.pagination.page,this.pagination.rowsPerPage,this.maltType, this.switchOnlyAboveSevenPct?7:0);          
          this.items = res.data;          
      },
      computed: {
            pages() {
                return 5
            },
            totalItemCount() {
                return 100
            }
      },      
      data: () => ({      
        search: '',
        // totalItems: 0,
        items: [],
        pagination: {
          sortBy: 'name',
          page:1,
          rowsPerPage:5,          
        },
        headers: [   
          { text: 'Name', value: 'name' },     
          { text: 'Alcohol by volume', value:'abv'},
          { text: 'tagline', value:'tagline'}
        ],
        //switch        
        switchOnlyAboveSevenPct:false,  
        maltType:"Extra_Pale"          
      })          
  }