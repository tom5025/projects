import { Injectable } from '@angular/core';

import { Observable } from 'rxjs';

import { catchError, map, tap, retry } from 'rxjs/operators';

import { BaseService } from './base.service';
import { Brand } from '../models/Brand';

@Injectable()

export class BrandsService extends BaseService {

    // httpOptions = { 
    //     headers: new HttpHeaders({
    //         'Content-Type':'application/json'
    //     })
    // }

    public GetBrands(): Observable<Brand> {
        return this.http.get<Brand>(this.pathAPI + 'brands')
            .pipe(retry(1), catchError(this.handleError));
    }
}