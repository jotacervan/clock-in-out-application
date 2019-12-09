import React, { useState } from 'react';
import Card from '@material-ui/core/Card';
import CardContent from '@material-ui/core/CardContent';
import Button from '@material-ui/core/Button';
import TextField from '@material-ui/core/TextField';
import Typography from '@material-ui/core/Typography';
import AccessTimeIcon from '@material-ui/icons/AccessTime';
import Swal from 'sweetalert2';

import { Container, LoginForm } from './style';
import api from '../../services/api';

export default function AddEntry(){

  const handleAddEntry = e => {
    e.preventDefault()
    let formData = new FormData(e.target)
    api.post('/register_entry', formData).then(res => {
      Swal.fire({
        icon: 'success',
        title: 'Entry registered successfully',
        showConfirmButton: false,
        timer: 1500
      })
    }).catch(res => {
      Swal.fire({
        icon: 'error',
        title: 'Something went wrong',
        showConfirmButton: false,
        timer: 1500
      })
    })
  }

  return(
    <Container>
      <Card className="card">
        <CardContent>
          <AccessTimeIcon className="clock-icon" />
          <Typography variant="h5" component="h2">Clock Event App</Typography>
          <Typography component="p">Fill with your user and password to add an entry at the current time</Typography>
          <LoginForm onSubmit={handleAddEntry}>
            <TextField type="email" name="email" label="Email" />
            <TextField type="password" name="password" label="Password" />
            <div className="button-group">
              <Button type="submit" variant="contained" color="primary">
                Add Entry
              </Button>
            </div>
          </LoginForm>
        </CardContent>
      </Card>
    </Container>
  )
}