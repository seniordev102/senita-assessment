import React, { useState, useEffect } from 'react';
import { TextField, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, TableSortLabel, Paper, TablePagination } from '@mui/material';
import { fetchPeople } from '../api/index.ts';
import { parseFetchPeopleApiResponse } from '../utils/index.ts';
import { Person, Pagination } from '../types/index.ts';

const PeopleTable = () => {
  const [people, setPeople] = useState<Person[]>([]);
  const [pagination, setPagination] = useState<Pagination | null>(null);
  const [search, setSearch] = useState('');
  const [sortBy, setSortBy] = useState('first_name');
  const [sortOrder, setSortOrder] = useState<"asc" | "desc">("asc");

  const [currentPage, setCurrentPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);
  const loadPeople = async () => {
    try {
      const response = await fetchPeople({
        page: currentPage + 1,
        size: rowsPerPage,
        search,
        sort_by: sortBy,
        sort_order: sortOrder,
      });
      setPeople(parseFetchPeopleApiResponse(response));
      setPagination(response.pagination);
    } catch (error) {
      console.error('Error fetching people data:', error);
    }
  };

  useEffect(() => {
    loadPeople();
  }, [currentPage, search, sortBy, sortOrder, rowsPerPage]);

  const handleSearchChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setSearch(e.target.value);
  };

  const handleSort = (column: string) => {
    const isAsc = sortBy === column && sortOrder === 'asc';
    setSortBy(column);
    setSortOrder(isAsc ? 'desc' : 'asc');
  };

  const handlePageChange = (event: unknown, newPage: number) => {
    setCurrentPage(newPage);
  };

  const handleRowsPerPageChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setRowsPerPage(parseInt(event.target.value, 10));
    setCurrentPage(0);
  };

  const renderTableCell = (value: any) => (
    <TableCell>{value || '-'}</TableCell>
  );

  return (
    <Paper style={{ padding: '20px' }}>
      <TextField
        variant="outlined"
        value={search}
        onChange={handleSearchChange}
        placeholder="Search by name"
        style={{ marginBottom: '20px', width: '300px' }}
      />
      <TableContainer>
        <Table>
          <TableHead>
            <TableRow>
              {['first_name', 'last_name', 'species', 'gender', 'weapon', 'vehicle'].map((column) => (
                <React.Fragment key={column}>
                  <TableCell>
                    <TableSortLabel active={sortBy === column} direction={sortOrder} onClick={() => handleSort(column)}>
                      {column.charAt(0).toUpperCase() + column.slice(1).replace('_', ' ')}
                    </TableSortLabel>
                  </TableCell>
                </React.Fragment>
              ))}
              <TableCell>Location</TableCell>
              <TableCell>Affiliations</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {people.map((person: Person) => (
              <TableRow key={person.id}>
                {renderTableCell(person.first_name)}
                {renderTableCell(person.last_name)}
                {renderTableCell(person.species)}
                {renderTableCell(person.gender)}
                {renderTableCell(person.weapon)}
                {renderTableCell(person.vehicle)}
                <TableCell>{person.locations.map((loc) => loc.name).join(', ')}</TableCell>
                <TableCell>{person.affiliations.map((aff) => aff.name).join(', ')}</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>
      <TablePagination
        rowsPerPageOptions={[5, 10, 25]}
        component="div"
        count={pagination?.total_count || 0}
        rowsPerPage={rowsPerPage}
        page={currentPage}
        onPageChange={handlePageChange}
        onRowsPerPageChange={handleRowsPerPageChange}
      />
    </Paper>
  );
};

export default PeopleTable;