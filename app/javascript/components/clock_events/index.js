import React, { useState, useEffect } from 'react';
import DataTable from 'react-data-table-component';
import TextField from '@material-ui/core/TextField';

import { Container } from './style';
import PageLoader from '../PageLoader';

export default function ClockEvents() {
  const [loaded, setLoaded] = useState(false);
  const [data, setData] = useState([]);
  const columns = [
    {
      name: 'Date',
      selector: 'date_reg',
      sortable: true,
      center: true
    },
    { name: 'Month', selector: 'month', sortable: true, center: true },
    { name: 'Week', selector: 'week', sortable: true, center: true },
    { name: 'Hours', selector: 'hours', sortable: true, center: true },
    { name: 'Fase', selector: 'phase', sortable: true, center: true }
  ];
  const [filterText, setFilterText] = useState('');
  const filteredItems = data.filter(item => item.date_reg && item.date_reg.toLowerCase().includes(filterText.toLowerCase()));

  useEffect(() => {
    setLoaded(true);
  }, [])

  return(
    <Container>
      <PageLoader loaded={loaded} />
      <h1>Clock Events</h1>
      {data && (
        <>
          <TextField id="standard-basic" label="Search Date" value={filterText} onChange={e => setFilterText(e.target.value)} />
          <DataTable
            columns={columns}
            data={filteredItems}
            highlightOnHover
          />
        </>
      )}
    </Container>
  )
}