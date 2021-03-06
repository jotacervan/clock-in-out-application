import React from 'react';
import Card from '@material-ui/core/Card';
import CardContent from '@material-ui/core/CardContent';
import Button from '@material-ui/core/Button';
import TextField from '@material-ui/core/TextField';
import Typography from '@material-ui/core/Typography';
import AccessTimeIcon from '@material-ui/icons/AccessTime';

import { Container, LoginForm } from './style';

export default function SignIn(){
  return(
    <Container>
      <Card className="card">
        <CardContent>
          <AccessTimeIcon className="clock-icon" />
          <Typography variant="h5" component="h2">Clock Event App</Typography>
          <Typography component="p">Welcome</Typography>
          <LoginForm>
            <TextField type="email" name="user[email]" label="Email" />
            <TextField type="password" name="user[password]" label="Password" />
            <div className="button-group">
              <Button variant="contained" href="/users/sign_up" color="primary">
                Sign Up
              </Button>
              <Button type="submit" variant="contained" color="primary">
                Log In
              </Button>
            </div>
          </LoginForm>
        </CardContent>
      </Card>
    </Container>
  )
}