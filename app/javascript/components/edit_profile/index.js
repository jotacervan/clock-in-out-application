import React, { useContext } from 'react';
import TextField from '@material-ui/core/TextField';
import InputLabel from '@material-ui/core/InputLabel';
import FormControl from '@material-ui/core/FormControl';
import Select from '@material-ui/core/Select';
import MenuItem from '@material-ui/core/MenuItem';
import Button from '@material-ui/core/Button';
import Paper from '@material-ui/core/Paper';
import Grid from '@material-ui/core/Grid';
import Swal from 'sweetalert2';

import { Container } from './style';
import { MainContext } from '../../main_context';
import api from '../../services/api';

export default function EditProfile() {
  const [currentUser, setCurrentUser] = useContext(MainContext);

  const handleUserSubmit = async (e) => {
    e.preventDefault()
    let formData = new FormData(e.target);
    await api.put(`/user/${currentUser.id}`, formData).then(({data}) => {
      setCurrentUser(data);
      Swal.fire({
        icon: 'success',
        title: 'Profile updated successfully',
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
        <h1>Edit Profile</h1>
        <form onSubmit={handleUserSubmit} >
          <Grid container spacing={2}>
            <Grid item xs={12} sm={6} md={3}>
              <TextField id="standard-basic" fullWidth name='user[name]' label="Name" defaultValue={currentUser.name} />
            </Grid>
            <Grid item xs={12} sm={6} md={3}>
              <TextField id="standard-basic" fullWidth name='user[email]' label="Email" defaultValue={currentUser.email} />
            </Grid>
            <Grid item xs={12} sm={6} md={3}>
              <TextField id="standard-basic" fullWidth name='user[hours_per_week]' type="number" label="Hours per week" defaultValue={currentUser.hours_per_week} />
            </Grid>
            <Grid item xs={12} sm={6} md={3}>
              <FormControl fullWidth>
                <InputLabel id="role">Role</InputLabel>
                <Select
                  labelId="role"
                  id="role-select"
                  fullWidth
                  name='user[role]'
                  defaultValue={currentUser.role}
                >
                  <MenuItem value={'user'}>User</MenuItem>
                  <MenuItem value={'supervisor'}>Supervisor</MenuItem>
                  <MenuItem value={'admin'}>Administrator</MenuItem>
                </Select>
              </FormControl>
            </Grid>
          </Grid>
          <br />
          <Button type="submit" variant="contained" color="primary" >Save</Button>
        </form>
      </Paper>
    </Container>
  )
}