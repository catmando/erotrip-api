  class EaRange < Hyperloop::Component

    param selection: [20, 30]
    param name: "no_name_configured"
    param min: 18
    param max: 40


    def changed(val)
      mutate.selection val
      nil
    end

    before_mount do; end

    after_mount do
      mutate.selection params[:selection]
      mutate.default_selection params[:selection]
    end

    before_update do; end

    before_unmount do; end

    def render
      DIV(class: 'range') do
        DIV(class: 'value-min') do
          "#{state.selection ? state.selection[0] : ''}"
        end

        Slider.Range(name: params[:name], defaultValue: state.default_selection, onChange: lambda{ |val| changed(val)} )

        DIV(class: 'value-max') do
          "#{state.selection ? state.selection[1] : ''}"
        end
      end
    end
  end


# import React from 'react'
# import ReactDOM from 'react-dom'
# import PropTypes from 'prop-types'

# import Slider, { Range } from 'rc-slider';
# import 'rc-slider/assets/index.css';

# class EaRange extends React.Component {

#   constructor(props) {
#     super(props);
#     this.state = {
#       min: 18,
#       max: 40,
#       defaultValue: [20, 30],
#       value: [20, 30]
#     };
#     this.onChange = this.onChange.bind(this)
#   }

#   onChange(val) {
#     this.setState({value: val});
#   }

#   render() {
#     return (
#       <div className="range">
#         <div className="value-min"> {this.state.value[0]} </div>
#         <Range
#           min={this.state.min}
#           max={this.state.max}
#           defaultValue={this.state.defaultValue}
#           onChange={this.onChange}
#         />
#         <div className="value-max"> {this.state.value[1]} </div>
#       </div>
#     )
#   }
# }

# export default EaRange;