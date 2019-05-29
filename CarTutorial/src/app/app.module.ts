import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './layout/app.component';

import { MatButtonModule, MatCheckboxModule, MatTabsModule, MatToolbarModule, MatIconModule } from '@angular/material';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSidenavModule } from '@angular/material/sidenav';
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
import { LeftPanelComponent } from './layout/left-panel.component';
import { BrandListComponent } from './components/brand-list/brand-list.component';
import { NewArticleComponent } from './components/new-article/new-article.component';

@NgModule({
  declarations: [
    AppComponent,
    HeadComponent,
    LeftPanelComponent,
    DashboardComponent,
    UsersComponent,
    BrandListComponent,
    NewArticleComponent
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    MatButtonModule,
    MatCheckboxModule,
    MatInputModule,
    MatFormFieldModule,
    MatIconModule,

    MatSidenavModule,
    MatTabsModule,
    MatToolbarModule,

    AppRoutingModule,

    HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
