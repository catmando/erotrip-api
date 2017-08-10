import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import Select from 'react-select'

class EaMultiSelectWithLabels extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      selection: "",
      options: [
        { value: 'dancing', label: 'Dancing' },
        { value: 'walking', label: 'Walking' },
        { value: 'flying', label: 'Flying' }
      ],
      storedSelections: [],
      placeholder: props.placeholder
    };
    this.add = this.add.bind(this);
    this.remove = this.remove.bind(this);
  }

  add(val) {
    this.setState({selection: null});
    if (!this.state.storedSelections.includes(val)) {
      this.setState({storedSelections:[...this.state.storedSelections, val]});
    }

  }

  remove(index) {
    const items = this.state.storedSelections.filter((e, itemIndex) => {
      return itemIndex !== index;
    })
    this.setState({storedSelections: items});
    console.log("items", items);
  }

  render() {
    return (
      <div className="select-with-labels">
        <Select
          name="form-field-name"
          value={this.state.selection}
          options={this.state.options}
          onChange={this.add}
          placeholder={this.state.placeholder}
        />
        <div className="labels-wrapper">
          {
            this.state.storedSelections.map(function(listValue, index) {
              return (<div className="badge badge-default mr-2" key={index}>
                <span> {listValue.value} </span>
                <button type="button" className="btn btn-link" onClick={(e) => { this.remove(index)}}> x </button>
                </div>);
            }, this)
          }
        </div>
      </div>
    )
  }
}

export default EaMultiSelectWithLabels;
