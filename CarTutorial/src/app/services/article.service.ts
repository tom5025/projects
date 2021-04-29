import { Injectable } from '@angular/core';

import { HttpClient, HttpHeaders } from '@angular/common/http';

import { Observable } from 'rxjs';

// import { of } from 'rxjs/observable/of';

import { catchError, map, tap } from 'rxjs/operators';

import { Helpers } from '../helpers/helpers';

import {BaseService} from './base.service';
import { AppConfig } from '../config/config';
import { Article } from '../models/Article';

@Injectable()

export class ArticleService extends BaseService {

    
    public AddArticle(art:Article) {
        this.http.post(this.pathAPI + 'article', art);
        //this.http.post
    }

    public ModArticle(art : Article)
    {
        this.http.put(this.pathAPI + 'article', art);
    }

}