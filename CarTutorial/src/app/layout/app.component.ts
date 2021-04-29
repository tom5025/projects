import { Component, AfterViewInit } from '@angular/core';
import { Helpers} from '../helpers/helpers'
import { Subscription } from 'rxjs';
import { startWith, delay } from 'rxjs/operators';

@Component({
  selector:'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements AfterViewInit {

  //subscription: Subscription;

  //authentication: boolean;

  // constructor(private helpers: Helpers) {
  //   console.log("built appcomponent");
  // }

  ngAfterViewInit() {

    console.log("built appcomponent");
    // this.subscription = this.helpers.isAuthenticationChanged().pipe(

    //   startWith(this.helpers.isAuthenticated()),

    //   delay(0)).subscribe((value) =>

    //     this.authentication = value

    //   );

  }

  title = 'Angular 5 Seed';

  ngOnDestroy() {

    //this.subscription.unsubscribe();

  }

}