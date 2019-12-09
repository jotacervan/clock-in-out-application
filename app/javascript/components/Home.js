import React from "react"
import { BrowserRouter } from 'react-router-dom'
import CssBaseline from '@material-ui/core/CssBaseline';

import Routes from './Routes'
import MainProvider from '../main_context';
import { Container } from './style'
import AppBar from  './app_bar'

export default function Home({ current_user }) {

  return (
    <BrowserRouter>
      <MainProvider current_user={current_user} >
        <Container >
          <CssBaseline />
          <AppBar />
          <main className='main'>
            <div className='toolbar'/>
            <Routes />
          </main>
        </Container>
      </MainProvider>
    </BrowserRouter>
  )
}
