import { FormServiceService } from './services/form-service.service';
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app/app-routing.module';
import { AppComponent } from './app/app.component';

import { FormsModule } from '@angular/forms';
import { FormElemComponent } from './app/form/form.component'


@NgModule({
  declarations: [
    AppComponent,
    FormElemComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule        
  ],
  providers: [FormServiceService],
  bootstrap: [AppComponent]
})
export class AppModule { }
