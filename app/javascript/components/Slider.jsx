import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

import Slider, { Range } from 'rc-slider';
import 'rc-slider/assets/index.css';

class EaSlider extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      min: 18,
      max: 40,
      defaultValue: 30,
      value: 30
    };
    this.onChange = this.onChange.bind(this)
  }

  onChange(val) {
    this.setState({value: val});
  }

  render() {
    return (
      <div className="range">
        <Slider
          min={this.state.min}
          max={this.state.max}
          defaultValue={this.state.defaultValue}
          onChange={this.onChange}
        />
        <div className="value-max"> {this.state.value} </div>
      </div>
    )
  }
}

export default EaSlider;