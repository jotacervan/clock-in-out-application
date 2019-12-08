import React from "react"

import api from '../services/api'

export default function Home() {

  async function logOut(){
    await api.delete('/users/sign_out')
    location.reload()
  }

  return (
    <>
      <h1>First React Component</h1>
      <button type="button" onClick={logOut}>Logout</button>
    </>
  )
}
