import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { FormElemComponent } from './form.component';

describe('FormElemComponent', () => {
  let component: FormElemComponent;
  let fixture: ComponentFixture<FormElemComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ FormElemComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FormElemComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
