import { Component, OnInit } from '@angular/core';
import { BrandsService } from 'src/app/services/brands.service';
import { CatsService } from 'src/app/services/cats.service';

@Component({
  selector: 'app-new-article',
  templateUrl: './new-article.component.html',
  styleUrls: ['./new-article.component.css']
})
export class NewArticleComponent implements OnInit {

  public BrandList : any = [];
  public CatList : any = [];

  constructor(private brandsvc : BrandsService , private catsvc : CatsService) { 
    
  }

  ngOnInit() {
    this.brandsvc.GetBrands().subscribe({
      next: (data : {}) => { 
        this.BrandList = data;
        }
    })

    this.catsvc.GetCats().subscribe({
      next: (data :{}) => {
        this.CatList = data;
      }
    })
  }

}
