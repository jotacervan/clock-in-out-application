import styled from 'styled-components'

export const Container = styled.div`
  height: 100%;
  padding:10px 0;
  display: flex;
  flex-direction:row;
  align-items: center;
  justify-content: center;

  .clock-icon {
    font-size:60px;
  }

  .card{
    min-width: 30%;
    text-align:center;
  }

  .button-group{
    display:flex;
    flex-direction:row;
    align-items: center;
    justify-content: flex-end;
  }
`

export const LoginForm = styled.form`
  display:flex;
  flex-direction: column;
  
  button, a {
    margin:10px 0 0 5px;
  }
`
