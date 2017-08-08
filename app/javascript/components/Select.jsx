import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

// var Select = require('react-select');
import Select from 'react-select'

class EaSelect extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      selection: "",
      options: [
        { value: 'one', label: 'One' },
        { value: 'two', label: 'Two' }
      ],
      placeholder: props.placeholder
    };
    this.logChange = this.logChange.bind(this);
  }

  logChange(val) {
    console.log("Selected: " + JSON.stringify(val));
    this.setState({selection: val});
  }

  // componentWillReceiveProps: function(nextProps) {
  //   this.setState({
  //     // set something
  //   });
  // }

  render() {
    return (
      <Select
        name="form-field-name"
        value={this.state.selection}
        options={this.state.options}
        onChange={this.logChange}
        placeholder={this.state.placeholder}
      />
    )
  }
}

export default EaSelect;