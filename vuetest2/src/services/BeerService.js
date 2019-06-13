'use strict';

import Axios from 'axios';

export default class BeerService
{
    getBeers (skip, rowsPerPage, maltType, alcoholByVol)
    {
        maltType.replace(' ', '_');                      
        console.log("ok");        
        return Axios.get(`https://api.punkapi.com/v2/beers?page=${skip}&per_page=${rowsPerPage}&malt=${maltType}${alcoholByVol!==0?"&abv_gt="+alcoholByVol:""}`); //
        
    }
}