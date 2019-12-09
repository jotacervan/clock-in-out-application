import React, { useContext } from 'react';
import TextField from '@material-ui/core/TextField';
import Button from '@material-ui/core/Button';
import Paper from '@material-ui/core/Paper';
import Grid from '@material-ui/core/Grid';
import Swal from 'sweetalert2';

import { Container } from './style';
import { MainContext } from '../../main_context';
import api from '../../services/api';

export default function ChangePassword() {
  const [currentUser, setCurrentUser] = useContext(MainContext);

  const handleUserSubmit = async (e) => {
    e.preventDefault()
    let formData = new FormData(e.target);
    await api.put(`/user/${currentUser.id}`, formData).then(({data}) => {
      setCurrentUser(data);
      Swal.fire({
        icon: 'success',
        title: 'Password changed successfully',
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
      console.log(res);
    })
  }

  return(
    <Container>
      <Paper className="edit-profile">
        <h1>Change Password</h1>
        <form onSubmit={handleUserSubmit} >
          <Grid container spacing={2}>
            <Grid item xs={12} sm={6} md={3}>
              <TextField id="standard-basic" type='password' fullWidth name='user[password]' label="Password Confirmation" />
            </Grid>
            <Grid item xs={12} sm={6} md={3}>
              <TextField id="standard-basic" type='password' type='password' fullWidth name='user[password_confirmation]' label="Password Confirmation" />
            </Grid>
          </Grid>
          <br />
          <Button type="submit" variant="contained" color="primary" >Save</Button>
        </form>
      </Paper>
    </Container>
  )
}