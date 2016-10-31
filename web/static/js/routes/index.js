import { IndexRoute, Route }  from 'react-router';
import React                  from 'react';
import MainLayout             from '../layouts/main';
import AuthenticatedContainer from '../containers/authenticated';
import HomeIndexView          from '../views/home';

export default (
  <Route component={ MainLayout }>
    <Route path="/" component={ AuthenticatedContainer }>
      <IndexRoute component={ HomeIndexView } />
    </Route>
  </Route>
);
