import { NgModule }             from '@angular/core';

import { RouterModule, Routes } from '@angular/router';

import { AuthGuard }                from './helpers/canActivateAuthGuard';

import { LoginComponent }   from './components/login/login.component';

import { LogoutComponent }   from './components/login/logout.component';

import { DashboardComponent }   from './components/dashboard/dashboard.component';

import { UsersComponent }      from './components/users/users.component';

const routes: Routes = [

  { path: '', redirectTo: '/dashboard', pathMatch: 'full', canActivate: [] },

  //{ path: 'login', component: LoginComponent},

  //{ path: 'logout', component: LogoutComponent},

  { path: 'dashboard', component: DashboardComponent, canActivate: [AuthGuard] },

  { path: 'users', component: UsersComponent,canActivate: [AuthGuard] }

];

@NgModule({

  imports: [ RouterModule.forRoot(routes) ],

  exports: [ RouterModule ]

})

export class AppRoutingModule {}
