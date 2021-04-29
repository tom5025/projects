import { CanActivate, Router } from '@angular/router';

import { Injectable } from '@angular/core';

import { Observable } from 'rxjs';

import { Helpers } from './helpers';

import { ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';

@Injectable()

export class AuthGuard implements CanActivate {

  constructor(private router: Router, private helper: Helpers) {}

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<boolean> | boolean {

    console.log("a");
    // if (!this.helper.isAuthenticated()) {

    //   console.log("not auth");
    //   this.router.navigate(['/login']);

    //   return false;

    // }

    return true;

  }

}