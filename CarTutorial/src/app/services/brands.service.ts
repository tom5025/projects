import { Injectable } from '@angular/core';

import { HttpClient, HttpHeaders } from '@angular/common/http';

import { Observable, throwError } from 'rxjs';

// import { of } from 'rxjs/observable/of';

import { catchError, map, tap, retry } from 'rxjs/operators';

import { Helpers } from '../helpers/helpers';

import {BaseService} from './base.service';
import { AppConfig } from '../config/config';
import { Article } from '../models/Article';
import { Brand } from '../models/Brand';

@Injectable()

export class BrandsService extends BaseService {

    httpOptions = { 
        headers: new HttpHeaders({
            'Content-Type':'application/json'
        })
    }

    public GetBrands() : Observable<Brand>
    {
        return this.http.get<Brand>(this.pathAPI + 'brands')
            .pipe(retry(1),catchError(this.handleError));        
    }
}