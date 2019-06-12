'use strict';

import Axios from 'axios';

export default class BeerService
{
    getBeers (skip, rowsPerPage, maltType, alcoholByVol)
    {
        maltType.replace(' ', '_');                      
        return Axios.get(`https://api.punkapi.com/v2/beers?page=${skip}&per_page=${rowsPerPage}&malt=${maltType}&abv_gt=${alcoholByVol}`);
    }
}