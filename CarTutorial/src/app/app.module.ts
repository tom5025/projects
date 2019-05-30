import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './layout/app.component';

import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { HttpClientModule } from '@angular/common/http';
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
import { LeftPanelComponent } from './layout/left-panel.component';
import { MaterialModule } from './material';

@NgModule({
  declarations: [
    AppComponent,
    HeadComponent,
    DashboardComponent,
    UsersComponent,
    BrandListComponent,
    NewArticleComponent,
    LeftPanelComponent
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    MaterialModule,

    AppRoutingModule,

    HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
