import React from 'react'
import ReactDatePicker from 'react-datepicker'

const DatePicker = ({ select, date, startDate, endDate }) => (
  <ReactDatePicker onChange={(e) => select(e)} selected={date} dateFormat="YYYY/MM/DD" placeholderText="Select a date" minDate={startDate} maxDate={endDate} isClearable={true} />
)

export default DatePicker