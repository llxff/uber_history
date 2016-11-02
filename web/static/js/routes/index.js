import { IndexRoute, Route }  from 'react-router';
import React                  from 'react';
import MainLayout             from '../layouts/main';
import SessionsNew            from '../views/sessions/new';
import AuthenticatedContainer from '../containers/authenticated';
import HomeIndexView          from '../views/home';

export default (
  <Route component={ MainLayout }>
    <Route path="/sign_in" component={ SessionsNew } />

    <Route path="/" component={ AuthenticatedContainer }>
      <IndexRoute component={ HomeIndexView } />
    </Route>
  </Route>
);
