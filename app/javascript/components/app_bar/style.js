import styled from 'styled-components'

export const Container = styled.div`
  .menu-button{
    margin-right: 16px;
  }
  .toolbar{
    min-height: 64px;
  }
  .drawer-paper{
    width: 240px;
  }
  .drawer-paper-smUp{
    width: 240px;
    z-index:990;
  }
  @media (min-width: 600px){
    .app-bar {
        width: calc(100% - 240px);
        margin-left: 240px;
    }
    .menu-button{
      display: none;
    }
    .drawer {
        width: 240px;
        flex-shrink: 0;
    }
  }
`

export const ModalContent = styled.div`
  background: #ffffff;
  left:50%;
  right: 50%;
  max-width: 500px;
  margin: 40px auto;
  padding: 10px 20px 20px;
`
