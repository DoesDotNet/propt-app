import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MsalGuard } from '@azure/msal-angular';
import { GuardedComponent } from './guarded/guarded.component';
import { HomeComponent } from './home/home.component';

const routes: Routes = [
  {
    path: 'guarded',
    component: GuardedComponent,
    canActivate: [
      MsalGuard
    ]
  },
  {
    // Needed for hash routing
    path: 'error',
    component: HomeComponent
  },
  {
    // Needed for hash routing
    path: 'state',
    component: HomeComponent
  },
  {
    // Needed for hash routing
    path: 'code',
    component: HomeComponent
  },
  {
    path: '',
    component: HomeComponent
  }
];

const isIframe = window !== window.parent && !window.opener;

@NgModule({
  imports: [RouterModule.forRoot(routes, {
    useHash: true,
    // Don't perform initial navigation in iframes
    initialNavigation: !isIframe ? 'enabled' : 'disabled'
  })],
  exports: [RouterModule]
})
export class AppRoutingModule { }