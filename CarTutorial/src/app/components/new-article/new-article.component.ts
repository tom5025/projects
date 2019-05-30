import { Component, OnInit } from '@angular/core';
import { BrandsService } from 'src/app/services/brands.service';

@Component({
  selector: 'app-new-article',
  templateUrl: './new-article.component.html',
  styleUrls: ['./new-article.component.css']
})
export class NewArticleComponent implements OnInit {

  public brandList

  constructor(private brandsvc : BrandsService) { 
    this.brandList = this.brandsvc.GetBrands();    
  }

  ngOnInit() {
  }

}
