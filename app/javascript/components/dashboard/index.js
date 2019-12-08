import React, { useContext, useState, useEffect } from 'react';
import Paper from '@material-ui/core/Paper';
import Typography from '@material-ui/core/Typography';
import Button from '@material-ui/core/Button';
import Divider from '@material-ui/core/Divider';

import { Container, GroupIndicators } from './style';
import { MainContext } from '../../main_context';
import api from '../../services/api';

export default function Dashboard() {
  const [currentUser] = useContext(MainContext);
  const [odd, setOdd] = useState([]);
  const [weekBalance, setWeekBalance] = useState('00:00:00');

  useEffect(() => {
    api.get('/dashboard/index').then(({data}) => {
      setWeekBalance(data.week_balance)
      setOdd(data.odd_days)
    }).catch(res => {
      console.log(res)
    })
  }, []);

  return (
    <Container>
      <Paper className='welcome-card'>
        <div>
          <Typography compoent='p'>Welcome, </Typography>
          <Typography variant='h5' compoent='h5'>
            {currentUser.name}
          </Typography>
          <Divider />
          <Typography compoent='p'>{currentUser.email}</Typography>
          <Typography compoent='p'>Week hours: {currentUser.hours_per_week}h</Typography>
        </div>
        <Button variant='contained'>Access Profile</Button>
      </Paper>
      <Divider className="section-divider" />
      <GroupIndicators>
        <Paper className="indicator">
          Week Balance
          <Divider />
          <div className="week-balance">{weekBalance}</div>
        </Paper>
        <Paper className="indicator">
          Missing Entries
          <Divider />
          {odd.length < 1 &&
            <div className="missing-entries">You don't have missing entries</div>
          }
        </Paper>
      </GroupIndicators>
    </Container>
  );
}
