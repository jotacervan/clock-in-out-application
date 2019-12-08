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
import { useTheme } from '@material-ui/core/styles';

import { Container } from './style';
import api from '../../services/api';

export default function TopBar(props){
  const { container } = props;
  const theme = useTheme();
  const [mobileOpen, setMobileOpen] = useState(false);
  
  const handleDrawerToggle = () => {
    setMobileOpen(!mobileOpen);
  };

  const handleLogOut = async () => {
    await api.delete('/users/sign_out').catch(res => {
      console.log(res)
    })
    location.reload();
  }

  return (
    <Container>
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
          <Typography variant="h6" noWrap>
            Clock Event App
          </Typography>
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
            <div>
              <div className='toolbar' />
              <Divider />
              <List>
                <ListItem button>
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
          </Drawer>
        </Hidden>
        <Hidden xsDown implementation="css">
          <Drawer
            classes={{paper: 'drawer-paper'}}
            variant="permanent"
            open
          >
            <div>
              <div className='toolbar' />
              <Divider />
              <List>
                <ListItem button>
                  <ListItemIcon><InboxIcon /></ListItemIcon>
                  <ListItemText primary='Dashboard' />
                </ListItem>
              </List>
              <Divider />
              <List>
                <ListItem button onClick={handleLogOut}>
                  <ListItemIcon><InboxIcon /></ListItemIcon>
                  <ListItemText primary='Logout' />
                </ListItem>
              </List>
            </div>
          </Drawer>
        </Hidden>
      </nav>
    </Container>
  );
}