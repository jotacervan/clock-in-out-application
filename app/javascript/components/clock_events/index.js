import React, { useState, useEffect } from 'react';
import DataTable from 'react-data-table-component';
import TextField from '@material-ui/core/TextField';
import Grid from '@material-ui/core/Grid';
import Chip from '@material-ui/core/Chip';
import Paper from '@material-ui/core/Paper';
import Button from '@material-ui/core/Button';
import DateFnsUtils from '@date-io/date-fns';
import {
  MuiPickersUtilsProvider,
  KeyboardTimePicker,
} from '@material-ui/pickers';

import { Container } from './style';
import PageLoader from '../PageLoader';
import api from '../../services/api';

export default function ClockEvents() {
  const [loaded, setLoaded] = useState(false);
  const [selected, setSelected] = useState(null);
  const [selectedTime, setSelectedTime] = useState(null);
  const [data, setData] = useState([]);
  const columns = [
    {
      name: 'Date',
      selector: 'date_reg',
      sortable: true,
      center: true,
      cell: row => <a className="date-click" onClick={() => handleSelectDay(row.id)}>{row.date_reg}</a>
    },
    { name: 'Month', selector: 'month_name', sortable: true, center: true },
    { name: 'Week', selector: 'week', sortable: true, center: true },
    { name: 'Worked Hours', selector: 'hours', sortable: true, center: true },
    { name: 'Missing', selector: 'status', sortable: true, center: true }
  ];
  const [filterText, setFilterText] = useState('');
  const filteredItems = data.filter(
    item => item.date_reg && item.date_reg.toLowerCase().includes(filterText.toLowerCase())
  );

  const handleSelectDay = async (id) => {
    await api.get(`/day/${id}`).then(({data}) => {
      setSelected(data)
      setSelectedTime(null)
    }).catch(res => {
      console.log('error', error)
    })
  }

  const handleTimeChange = date => {
    setSelectedTime({ ...selectedTime, time_reg: date});
  };

  const handleEditTime = async () => {
    await api.put(`time_reg/${selectedTime.id}`, { time_reg: selectedTime.time_reg }).then(res => {
      setSelectedTime(null)
    }).catch(res => {
      console.log(res)
    })
    location.reload()
  }

  const handleDestroyTime = async () => {
    await api.delete(`time_reg/${selectedTime.id}`).then(res => {
      setSelectedTime(null)
    }).catch(res => {
      console.log(res)
    })
    location.reload()
  }

  useEffect(() => {
    api.get('/day').then(({data}) => {
      setData(data);
      setLoaded(true);
    }).catch(res => {
      console.log(res)
    });
  }, []);

  return (
    <Container>
      <PageLoader loaded={loaded} />
      <h1>Clock Events</h1>
      { selected && (
        <Paper className="selected-day">
          <p className="title">{ selected.date_reg }</p>
          <Grid container spacing={2} direction="row" justify="center" alignItems="center">
            { selected.time_regs.map((time, i) => (
              <Grid item key={time.id}>
                <Chip 
                  label={time.time} 
                  color={Math.abs(i % 2) == 1 ? 'default' : 'primary'}
                  component="a" 
                  href={ void(0) } 
                  onClick={() => setSelectedTime(time) }
                  clickable />
              </Grid>
            )) }
          </Grid>
          { selectedTime &&
            <Grid container spacing={2} direction="row" justify="center" alignItems="center" >
              <Grid item>
                <MuiPickersUtilsProvider utils={DateFnsUtils}>
                  <Grid container justify="space-around">
                    <KeyboardTimePicker
                      margin="normal"
                      id="time-picker"
                      label="Time"
                      value={selectedTime.time_reg}
                      onChange={handleTimeChange}
                      KeyboardButtonProps={{
                        'aria-label': 'change time',
                      }}
                    />
                  </Grid>
                </MuiPickersUtilsProvider>
              </Grid>
              <Grid item>
                <Button variant="contained" onClick={handleEditTime} color="primary">Edit</Button>
              </Grid>
              <Grid item>
                <Button variant="contained" onClick={handleDestroyTime} color="secondary">Delete</Button>
              </Grid>
            </Grid>
          }
          <br />
        </Paper>
      ) }
      {data && (
        <>
          <TextField
            id='standard-basic'
            label='Search Date'
            value={filterText}
            onChange={e => setFilterText(e.target.value)}
          />
          <DataTable columns={columns} data={filteredItems} pagination highlightOnHover />
        </>
      )}
    </Container>
  );
}
