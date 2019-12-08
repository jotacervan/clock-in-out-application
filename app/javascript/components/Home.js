import React from "react"
import { BrowserRouter } from 'react-router-dom'
import CssBaseline from '@material-ui/core/CssBaseline';

import Routes from './Routes'
import { Container } from './style'
import AppBar from  './app_bar'

export default function Home() {

  return (
    <BrowserRouter>
      <Container >
        <CssBaseline />
        <AppBar />
        <main className='main'>
          <div className='toolbar'/>
          <Routes />
        </main>
      </Container>
    </BrowserRouter>
  )
}
