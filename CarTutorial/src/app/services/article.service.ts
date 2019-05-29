import { Injectable } from '@angular/core';

import { HttpClient, HttpHeaders } from '@angular/common/http';

import { Observable } from 'rxjs';

// import { of } from 'rxjs/observable/of';

import { catchError, map, tap } from 'rxjs/operators';

import { Helpers } from '../helpers/helpers';

import {BaseService} from './base.service';
import { AppConfig } from '../config/config';

@Injectable()

export class ArticleService extends BaseService {

    constructor(private http: HttpClient, private config: AppConfig, helper: Helpers) { super(helper); }
    
    public AddArticle() {
        //this.http.post
    }

}