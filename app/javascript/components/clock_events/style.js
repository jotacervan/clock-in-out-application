import styled from 'styled-components';

export const Container = styled.div`
  .selected-day{
    text-align:center;
    padding: 8px;

    .title{
      font-size:30px;
    }
  }

  .date-click{
    cursor:pointer;
    text-decoration: underline;
  }
  .date-click:hover{
    color: #999;
  }
`