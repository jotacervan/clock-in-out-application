import React from 'react';
import { Switch, Route } from 'react-router-dom';
import Dashboard from './dashboard';
import ClockEvents from './clock_events';
import EditProfile from './edit_profile';
import ChangePassword from './change_password';
import NotFound from './not_found';

export default function Routes() {
  return (
    <Switch>
      <Route path='/' exact component={Dashboard} />
      <Route path='/clock_events' component={ClockEvents} />
      <Route path='/edit_profile' component={EditProfile} />
      <Route path='/change_password' component={ChangePassword} />
      <Route path='*' component={NotFound} />
    </Switch>
  );
}
