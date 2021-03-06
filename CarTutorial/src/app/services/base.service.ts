import { Injectable } from '@angular/core';

import { HttpClient, HttpHeaders } from '@angular/common/http';

import { Observable, throwError } from 'rxjs';

// import { of } from 'rxjs/observable/of';

import { catchError, map, tap } from 'rxjs/operators';

import { Helpers } from '../helpers/helpers';
import { AppConfig } from '../config/config';

@Injectable()

export class BaseService {

  protected pathAPI = this.config.setting['PathAPI'];

  constructor(protected http: HttpClient, protected helper: Helpers, protected config: AppConfig) { }

  public extractData(res: Response) {

    let body = res.json();

    return body || {};

  }

  handleError(error) {
    let errorMessage = '';
    if (error.error instanceof ErrorEvent) {
      // Get client-side error
      errorMessage = error.error.message;
    } else {
      // Get server-side error
      errorMessage = `Error Code: ${error.status}\nMessage: ${error.message}`;
    }
    window.alert(errorMessage);
    return throwError(errorMessage);
  }

    //   public handleError(error: Response | any) {

    //     // In a real-world app, we might use a remote logging infrastructure

    //     let errMsg: string;

    //     if (error instanceof Response) {

    //       const body = error.json() || '';

    //       const err = body || JSON.stringify(body);

    //       errMsg = `${error.status} - ${error.statusText || ''} ${err}`;

    //     } else {

    //       errMsg = error.message ? error.message : error.toString();

    //     }

    //     console.error(errMsg);

    //     return Observable.throw(errMsg);

      

    // }

    

  public header() {



    let header = new HttpHeaders({ 'Content-Type': 'application/json' });



    if (this.helper.isAuthenticated()) {

      header = header.append('Authorization', 'Bearer ' + this.helper.getToken());

    }



    return { headers: header };

  }



  public setToken(data: any) {



    this.helper.setToken(data);

  }

  public failToken(error: Response | any) {



    this.helper.failToken();

    return this.handleError(Response);

  }

 }
