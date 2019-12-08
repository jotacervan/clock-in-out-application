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