import React from 'react';
import { Switch, Route } from 'react-router-dom'
import Dashboard from './dashboard'
import NotFound from './not_found'

export default function Routes(){
  return(
    <Switch>
      <Route path="/" exact component={Dashboard} />
      <Route path="*" component={NotFound} />
    </Switch>
  )
}