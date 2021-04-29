import { Injectable } from '@angular/core';

import { Observable } from 'rxjs';



import { catchError, map, tap, retry } from 'rxjs/operators';

import {BaseService} from './base.service';
import { Cat } from '../models/Cat';

@Injectable()

export class CatsService extends BaseService {

    public GetCats() : Observable<Cat>
    {
        return this.http.get<Cat>(this.pathAPI + 'cat')
            .pipe(retry(1),catchError(this.handleError));        
    }
}