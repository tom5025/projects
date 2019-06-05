import { FormElement } from './../models/form-element';
import { Injectable } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';

@Injectable({
  providedIn: 'root'
})
export class FormServiceService {

  constructor() { }

  toFormGroup(elements : FormElement[]) : FormGroup
  {
    let group: any = {};

    elements.forEach(elem => {
      group[elem.key] = new FormControl(elem.amount, Validators.required);
    });

    return new FormGroup(group);
  }
}
