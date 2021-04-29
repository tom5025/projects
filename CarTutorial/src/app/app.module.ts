import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './layout/app.component';

import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { HttpClientModule, HttpClient } from '@angular/common/http';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { UsersComponent } from './components/users/users.component';
import { Helpers } from './helpers/helpers';
import { Router } from '@angular/router';
import { TokenService } from './services/token.service';

import 'hammerjs';
import { AuthGuard } from './helpers/canActivateAuthGuard';
import { HeadComponent } from './layout/head.component';
import { BrandListComponent } from './components/brand-list/brand-list.component';
import { NewArticleComponent } from './components/new-article/new-article.component';
import { MaterialModule } from './material';
import { BrandsService } from './services/brands.service';
import { AppConfig } from './config/config';
import { CatsService } from './services/cats.service';

@NgModule({
  declarations: [
    AppComponent,
    HeadComponent,
    DashboardComponent,
    UsersComponent,
    BrandListComponent,
    NewArticleComponent,
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    MaterialModule,

    AppRoutingModule,

    HttpClientModule
  ],
  providers: [BrandsService, CatsService, HttpClient, Helpers, AppConfig],
  bootstrap: [AppComponent]
})
export class AppModule { }
