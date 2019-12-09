import React, { useState } from 'react';
import AppBar from '@material-ui/core/AppBar';
import Divider from '@material-ui/core/Divider';
import Drawer from '@material-ui/core/Drawer';
import Hidden from '@material-ui/core/Hidden';
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

const Menu = () => (
  <div>
    <div className='toolbar'></div>
    <Divider />
    <List>
      <ListItem button component="a" href="/">
        <ListItemIcon><InboxIcon /></ListItemIcon>
        <ListItemText primary='Dashboard' />
      </ListItem>
    </List>
    <Divider />
    <List>
      <ListItem button>
        <ListItemIcon><InboxIcon /></ListItemIcon>
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
                label="Date picker inline"
                value={selectedDate}
                onChange={handleDateChange}
                KeyboardButtonProps={{
                  'aria-label': 'change date',
                }}
              />
              <KeyboardTimePicker
                margin="normal"
                id="time-picker"
                label="Time picker"
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
            <Menu />
          </Drawer>
        </Hidden>
        <Hidden xsDown implementation="css">
          <Drawer
            classes={{paper: 'drawer-paper'}}
            variant="permanent"
            open
          >
            <Menu />
          </Drawer>
        </Hidden>
      </nav>
    </Container>
  );
}