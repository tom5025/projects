import BeerService from '../services/BeerService';

/**
 * Load data from the beer service
 * @param {view data} ctx context
 */
async function LoadData(ctx) {
    let svc = new BeerService();
    const res = await svc.getBeers(ctx.pagination.page, ctx.pagination.rowsPerPage, ctx.maltType, ctx.switchOnlyAboveSevenPct ? 7 : 0);
    ctx.items = res.data;
}

export default{
      name:"BeerView",
      watch:
      {
          async switchOnlyAboveSevenPct(newValue){
            this.pagination.page = 1;
            await LoadData(this);
          },
          pagination:
          {
            async handler()
            {
              await LoadData(this);  
            }
          }
      },
      async mounted () {          
          await LoadData(this);          
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
          { text: 'tagline', value:'tagline'},
          { text: '', value:'image_url'}
        ],
        //switch        
        switchOnlyAboveSevenPct:false,  
        maltType:"Extra_Pale"          
      })          
  }