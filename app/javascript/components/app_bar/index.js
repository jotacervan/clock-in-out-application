import React, { useState } from 'react';
import AppBar from '@material-ui/core/AppBar';
import Divider from '@material-ui/core/Divider';
import Drawer from '@material-ui/core/Drawer';
import Hidden from '@material-ui/core/Hidden';
import AccessTimeIcon from '@material-ui/icons/AccessTime';
import ExitToAppIcon from '@material-ui/icons/ExitToApp';
import LockIcon from '@material-ui/icons/Lock';
import PermIdentityIcon from '@material-ui/icons/PermIdentity';
import HomeWorkIcon from '@material-ui/icons/HomeWork';
import IconButton from '@material-ui/core/IconButton';
import InboxIcon from '@material-ui/icons/MoveToInbox';
import List from '@material-ui/core/List';
import ListItem from '@material-ui/core/ListItem';
import ListItemIcon from '@material-ui/core/ListItemIcon';
import ListItemText from '@material-ui/core/ListItemText';
import MenuIcon from '@material-ui/icons/Menu';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import Button from '@material-ui/core/Button';
import Modal from '@material-ui/core/Modal';
import Grid from '@material-ui/core/Grid';
import DateFnsUtils from '@date-io/date-fns';
import { useTheme } from '@material-ui/core/styles';
import Swal from 'sweetalert2';
import {
  MuiPickersUtilsProvider,
  KeyboardTimePicker,
  KeyboardDatePicker,
} from '@material-ui/pickers';

import { Container, ModalContent } from './style';
import api from '../../services/api';

const Menu = ({handleLogOut}) => (
  <div>
    <div className='toolbar'></div>
    <Divider />
    <List>
      <ListItem button component="a" href="/">
        <ListItemIcon><HomeWorkIcon /></ListItemIcon>
        <ListItemText primary='Dashboard' />
      </ListItem>
      <ListItem button component="a" href="/clock_events">
        <ListItemIcon><AccessTimeIcon /></ListItemIcon>
        <ListItemText primary='Clock Events' />
      </ListItem>
      <ListItem button component="a" href="/edit_profile">
        <ListItemIcon><PermIdentityIcon /></ListItemIcon>
        <ListItemText primary='Edit Profile' />
      </ListItem>
      <ListItem button component="a" href="/change_password">
        <ListItemIcon><LockIcon /></ListItemIcon>
        <ListItemText primary='Change Password' />
      </ListItem>
    </List>
    <Divider />
    <List>
      <ListItem button onClick={handleLogOut}>
        <ListItemIcon><ExitToAppIcon /></ListItemIcon>
        <ListItemText primary='Logout' />
      </ListItem>
    </List>
  </div>
)

export default function TopBar(props){
  const [openModal, setOpen] = useState(false);
  const [selectedDate, setSelectedDate] = React.useState(new Date());
  const { container } = props;
  const theme = useTheme();
  const [mobileOpen, setMobileOpen] = useState(false);
  
  const handleDrawerToggle = () => {
    setMobileOpen(!mobileOpen);
  };

  const handleDateChange = date => {
    setSelectedDate(date);
  };

  const handleOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

  const handleAddEntry = async () => {
    await api.post('/time_reg', { time_reg: selectedDate }).then(res => {
      handleClose();
      Swal.fire({
        icon: 'success',
        title: 'Time entry added successfully',
        showConfirmButton: false,
        timer: 1500
      })
    }).catch(res => {
      console.log('Something wrong');
    })
    location.reload();
  }

  const handleLogOut = async () => {
    await api.delete('/users/sign_out').catch(res => {
      console.log(res)
    })
    location.reload();
  }

  return (
    <Container>
      <Modal
        aria-labelledby="simple-modal-title"
        aria-describedby="simple-modal-description"
        open={openModal}
        onClose={handleClose}
      >
        <ModalContent>
          <h2 id="simple-modal-title">New entry</h2>
          <p id="simple-modal-description">
            Select the time and date that you and to register.
          </p>
          <MuiPickersUtilsProvider utils={DateFnsUtils}>
            <Grid container justify="space-around">
              <KeyboardDatePicker
                disableToolbar
                variant="inline"
                format="yyyy-MM-dd"
                margin="normal"
                id="date-picker-inline"
                label="Date"
                value={selectedDate}
                onChange={handleDateChange}
                KeyboardButtonProps={{
                  'aria-label': 'change date',
                }}
              />
              <KeyboardTimePicker
                margin="normal"
                id="time-picker"
                label="Time"
                value={selectedDate}
                onChange={handleDateChange}
                KeyboardButtonProps={{
                  'aria-label': 'change time',
                }}
              />
            </Grid>
          </MuiPickersUtilsProvider>
          <Button variant="contained" onClick={handleAddEntry} color="primary">Add Entry</Button>
        </ModalContent>
      </Modal>
      <AppBar position="fixed" className='app-bar'>
        <Toolbar>
          <IconButton
            color="inherit"
            aria-label="open drawer"
            edge="start"
            onClick={handleDrawerToggle}
            className='menu-button'
          >
            <MenuIcon />
          </IconButton>
          <Typography variant="h6" style={{flexGrow: 1}} noWrap>
            Clock Event App
          </Typography>
          <Button color="inherit" onClick={handleOpen}>New Entry</Button>
        </Toolbar>
      </AppBar>
      <nav className='drawer' aria-label="mailbox folders">
        <Hidden smUp implementation="css">
          <Drawer
            container={container}
            variant="temporary"
            anchor={theme.direction === 'rtl' ? 'right' : 'left'}
            open={mobileOpen}
            onClose={handleDrawerToggle}
            classes={{paper: 'drawer-paper'}}
            ModalProps={{
              keepMounted: true, // Better open performance on mobile.
            }}
          >
            <Menu handleLogOut={handleLogOut} />
          </Drawer>
        </Hidden>
        <Hidden xsDown implementation="css">
          <Drawer
            classes={{paper: 'drawer-paper-smUp'}}
            variant="permanent"
            open
          >
            <Menu handleLogOut={handleLogOut} />
          </Drawer>
        </Hidden>
      </nav>
    </Container>
  );
}