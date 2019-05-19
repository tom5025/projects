import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormControl, Validators } from '@angular/forms';
import { Http, Response, Headers, RequestOptions } from '@angular/http';
import 'rxjs/Rx';


@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
})
export class HomeComponent {
  personForm: FormGroup;
  constructor(private fb: FormBuilder) {
    
  }

  ngOnInit() {
    this.personForm = this.fb.group({
      name: ['', Validators.required]
    });
  }

  updateName() {
    this.personForm.controls['name'].setValue('Nancy');
  }

  onSubmit() {
    console.warn(this.personForm.value);
  }
  //name = new FormControl('');
}
  //implements OnInit {

    //personForm: FormGroup;
    //successfulSave: boolean;
    //errors: string[];
 
    //constructor(private fb: FormBuilder, private http: Http) {
    //}
 
    //ngOnInit() {
    //    this.personForm = this.fb.group({
    //        title: [''],
    //        firstName: [''],
    //        surname: [''],
    //        emailAddress: ['']
    //    });
    //    this.errors = [];
    //}
 
    //onSubmit() {
    //    if (this.personForm.valid) {
    //        let headers = new Headers({ 'Content-Type': 'application/json' });
    //        let options = new RequestOptions({ headers: headers });
    //        let person = {
    //            title: this.personForm.value.title,
    //            firstName: this.personForm.value.firstName,
    //            surname: this.personForm.value.surname,
    //            emailAddress: this.personForm.value.emailAddress
    //        };
    //        this.errors = [];
    //        this.http.post('/api/person', JSON.stringify(person), options)
    //            .map(res => res.json())
    //            .subscribe(
    //                (data) => this.successfulSave = true,
    //                (err) => {
    //                    this.successfulSave = false;
    //                    if (err.status === 400) {
    //                        // handle validation error
    //                        let validationErrorDictionary = JSON.parse(err.text());
    //                        for (var fieldName in validationErrorDictionary) {
    //                            if (validationErrorDictionary.hasOwnProperty(fieldName)) {
    //                                this.errors.push(validationErrorDictionary[fieldName]);
    //                            }
    //                        }
    //                    } else {
    //                        this.errors.push("something went wrong!");
    //                    }
    //                });
    //    }
    //}
