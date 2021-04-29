import { FormElement } from './../../models/form-element';
import { Component, Input, OnInit } from '@angular/core';
import { FormGroup }        from '@angular/forms';

// composant d'un formulaire dynamique

@Component({
  selector: 'app-form-elem',
  templateUrl: './form-elem.component.html',
  styleUrls: ['./form-elem.component.sass']
})
export class FormElemComponent implements OnInit {

  @Input() elem : FormElement;
  @Input() form : FormGroup;

  get isValid() { return this.form.controls[this.elem.key].valid; }

  constructor() { }

  ngOnInit() {
  }

}