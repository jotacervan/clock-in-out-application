import styled from 'styled-components'

export const Container = styled.div`
  .welcome-card{
    padding: 40px;
    margin: 0 10px;
    display:flex;
    flex-direction: row;
    align-items:center;
    justify-content: space-between;

    div:first-child{
      flex-grow: 1; 
    }
    button{
      margin-left: 30px;
    }
  }
  .section-divider{
    margin: 20px 0;
  }
`

export const GroupIndicators = styled.div`
  display: flex;
  flex-direction: row;
  align-items: flex-start;
  justify-content: space-around;
  flex-wrap: wrap;

  .indicator{
    flex-grow:1;
    margin: 0 10px;
    padding: 25px;
  }

  .week-balance{
    text-align:center;
    margin-top: 10px;
    font-size:36px;
  }

  .missing-entries{
    text-align:center;
    margin-top: 10px;
    font-size:22px;
    padding:10px 0;
  }
`
