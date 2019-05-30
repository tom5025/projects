import { MatButtonModule, MatCheckboxModule, MatTabsModule, MatToolbarModule, MatIconModule } from '@angular/material';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSidenavModule } from '@angular/material/sidenav';
import { NgModule } from '@angular/core';

@NgModule({
    imports:[    MatButtonModule,
        MatCheckboxModule,
        MatInputModule,
        MatFormFieldModule,
        MatIconModule,
    
        MatSidenavModule,
        MatTabsModule,
        MatToolbarModule],
    exports:[MatButtonModule,
        MatCheckboxModule,
        MatInputModule,
        MatFormFieldModule,
        MatIconModule,
    
        MatSidenavModule,
        MatTabsModule,
        MatToolbarModule]
})
export class MaterialModule {}