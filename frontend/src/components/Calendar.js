import React, { Component } from "react";
import moment from 'moment';
import axios from "axios";
import  { Calendar as BigCalendar, momentLocalizer } from 'react-big-calendar';
import withDragAndDrop from 'react-big-calendar/lib/addons/dragAndDrop'
import Dialog from 'material-ui/Dialog';
import FlatButton from 'material-ui/FlatButton';
import TextField from 'material-ui/TextField';
import TimePicker from 'material-ui/TimePicker';
import 'react-big-calendar/lib/css/react-big-calendar.css';
import 'react-big-calendar/lib/addons/dragAndDrop/styles.css'

const BACKEND_API_URL = process.env.BACKEND_API_URL || "http://localhost:3000"

const localizer = momentLocalizer(moment);
const DnDCalendar = withDragAndDrop(BigCalendar)

class Calendar extends Component {
  constructor() {
    super();
    this.state = {
      events: [],
      title: "",
      start: "",
      end: "",
      desc: "",
      openSlot: false,
      openEvent: false,
      clickedEvent: {},
      token: localStorage.getItem('token')
    };

    this.handleClose = this.handleClose.bind(this);
  }

  handleClose() {
    this.setState({ openEvent: false, openSlot: false });
  }

  handleSlotSelected(slotInfo) {
    this.setState({
      title: "",
      desc: "",
      start: slotInfo.start,
      end: slotInfo.end,
      openSlot: true
    });
  }

  handleEventSelected(event) {
    this.setState({
      openEvent: true,
      clickedEvent: event,
      start: event.start,
      end: event.end,
      title: event.title,
      desc: event.desc
    });
  }

  setTitle(e) {
    this.setState({ title: e });
  }

  setDescription(e) {
    this.setState({ desc: e });
  }

  handleStartTime = (event, date) => {
    this.setState({ start: date });
  };

  handleEndTime = (event, date) => {
    this.setState({ end: date });
  };

  async setNewAppointment() {
    const { start, end, title, desc, token } = this.state;
    let appointment = { title, start, end, desc };
    let events = this.state.events.slice();
    events.push(appointment);
    this.setState({ events });

    try {
      await axios.post(`${BACKEND_API_URL}/appointments`, appointment, { headers: { Auth: `Bearer ${token}` } });
    } catch(error) {
      console.error(error);
    }
  }

  async updateEvent() {
    const { title, desc, start, end, events, clickedEvent, token } = this.state;
    const index = events.findIndex(event => event === clickedEvent);
    const updatedEvent = events.slice();

    updatedEvent[index].title = title;
    updatedEvent[index].desc = desc;
    updatedEvent[index].start = start;
    updatedEvent[index].end = end;

    this.setState({ events: updatedEvent });

    try {
      await axios.put(`${BACKEND_API_URL}/appointments/${updatedEvent[index].id}`, {
        title,
        desc,
        start,
        end
      }, { headers: { Auth: `Bearer ${token}` } });
    } catch(error) {
      console.error(error);
    }
  }

  async handleEventChangeBoundries({ event, start, end }) {
    const { token, events } = this.state;
    const { title, desc } = event
    const index = events.findIndex(ev => ev.id === event.id);
    const updatedEvent = events.slice();

    updatedEvent[index].start = start;
    updatedEvent[index].end = end;

    console.log(updatedEvent[index])

    this.setState({ events: updatedEvent });

    try {
      await axios.put(`${BACKEND_API_URL}/appointments/${event.id}`,
        { title, desc, start, end },
        { headers: { Auth: `Bearer ${token}` }}
      );
    } catch(error) {
      console.error(error);
    }
  }

  async deleteEvent() {
    const { clickedEvent, token, events } = this.state;
    const event_id = clickedEvent.id

    let updatedEvents = events.filter(
      event => event.id !== event_id
    );

    this.setState({ events: updatedEvents });

    try {
      await axios.delete(`${BACKEND_API_URL}/appointments/${clickedEvent.id}`, { headers: { Auth: `Bearer ${token}` } });
    } catch(error) {
      console.error(error);
    }
  }

  loadEvents() {
    const token = this.state.token

    axios
      .get(`${BACKEND_API_URL}/appointments`, { headers: { Auth: `Bearer ${token}` } })
      .then(response => {
        let events = response.data.appointments.map(event => {
          return Object.assign({}, event, {
            start: new Date(event.start),
            end: new Date(event.end)
          });
        });

        this.setState({ events: events});
      })
  }

  componentDidMount() {
    this.loadEvents();
  }

  render() {
    const eventActions = [
      <FlatButton
        label="Cancel"
        primary={false}
        keyboardFocused={true}
        onClick={this.handleClose} />,
      <FlatButton
        label="Delete"
        secondary={true}
        keyboardFocused={true}
        onClick={() => { this.deleteEvent(); this.handleClose() }} />,
      <FlatButton
        label="Confirm Edit"
        primary={true}
        keyboardFocused={true}
        onClick={() => { this.updateEvent(); this.handleClose() }} />
    ];
    const appointmentActions = [
      <FlatButton label="Cancel"
        secondary={true}
        onClick={this.handleClose} />,
      <FlatButton label="Submit"
        primary={true}
        keyboardFocused={true}
        onClick={()=> { this.setNewAppointment(); this.handleClose() }} />
    ];

    return (
      <div style={{ height: '500pt'}}>
        <DnDCalendar
          events={this.state.events}
          defaultView="week"
          defaultDate={moment().toDate()}
          onEventResize={(resizeInfo) => this.handleEventChangeBoundries(resizeInfo)}
          onEventDrop={(dropInfo) => this.handleEventChangeBoundries(dropInfo)}
          onSelectEvent={(event) => this.handleEventSelected(event)}
          onSelectSlot={(slotInfo) => this.handleSlotSelected(slotInfo)}
          selectable={true}
          localizer={localizer}
        />

        <Dialog
          title={`Book an appointment on ${moment(this.state.start).format(
            "MMMM Do YYYY"
          )}`}
          actions={appointmentActions}
          modal={false}
          open={this.state.openSlot}
          onRequestClose={this.handleClose}
        >
          <TextField
            floatingLabelText="Title"
            onChange={e => {
              this.setTitle(e.target.value);
            }}
          />
          <br />
          <TextField
            floatingLabelText="Description"
            onChange={e => {
              this.setDescription(e.target.value);
            }}
          />
          <TimePicker
            format="ampm"
            floatingLabelText="Start Time"
            minutesStep={5}
            value={new Date(this.state.start)}
            onChange={this.handleStartTime}
          />
          <TimePicker
            format="ampm"
            floatingLabelText="End Time"
            minutesStep={5}
            value={new Date(this.state.end)}
            onChange={this.handleEndTime}
          />
        </Dialog>

        <Dialog
          title={`View/Edit Appointment of ${moment(this.state.start).format(
            "MMMM Do YYYY"
          )}`}
          actions={eventActions}
          modal={false}
          open={this.state.openEvent}
          onRequestClose={this.handleClose}
        >
          <TextField
            defaultValue={this.state.title}
            floatingLabelText="Title"
            onChange={e => {
              this.setTitle(e.target.value);
            }}
          />
          <br />
          <TextField
            floatingLabelText="Description"
            multiLine={true}
            defaultValue={this.state.desc}
            onChange={e => {
              this.setDescription(e.target.value);
            }}
          />
          <TimePicker
            format="ampm"
            floatingLabelText="Start Time"
            minutesStep={5}
            value={new Date(this.state.start)}
            onChange={this.handleStartTime}
          />
          <TimePicker
            format="ampm"
            floatingLabelText="End Time"
            minutesStep={5}
            value={new Date(this.state.end)}
            onChange={this.handleEndTime}
          />
        </Dialog>
      </div>
    );
  }
}

export default Calendar;
