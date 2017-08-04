import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

import Select from 'react-select'

class EaMultiSelect extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      selection: "",
      options: [
        { value: 'one', label: 'One' },
        { value: 'two', label: 'Two' }
      ]
    };
    this.logChange = this.logChange.bind(this);
  }

  logChange(val) {
    console.log("Selected: " + JSON.stringify(val));
    this.setState({selection: val});
  }

  render() {
    return (
      <Select
        name="form-field-name"
        value={this.state.selection}
        options={this.state.options}
        onChange={this.logChange}
        multi={true}
      />
    )
  }
}

export default EaMultiSelect;
