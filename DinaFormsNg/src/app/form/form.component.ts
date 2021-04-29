import { FormElement } from '../../models/form-element';
import { FormServiceService } from '../../services/form-service.service';
import { Component, OnInit, Input } from '@angular/core';
import { FormGroup } from '@angular/forms';

//formulaire dynamique

@Component({
  selector: 'app-form',
  templateUrl: './form.component.html',
  styleUrls: ['./form.component.sass'],  
})
export class FormComponent implements OnInit {

  @Input() formElems : FormElement[] = [];
  form : FormGroup;
  payload : string = '';

  constructor(private fs : FormServiceService) { }

  ngOnInit() {
    this.form = this.fs.toFormGroup(this.formElems);
  }

  public onSubmit()
  {
    this.payload = JSON.stringify(this.form.value);
  }

}
