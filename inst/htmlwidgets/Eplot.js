HTMLWidgets.widget({
  name: 'Eplot',
  type: 'output',

  renderValue: function(el, option_value,  width, height) {
    var chart=echarts.init(el,'macarons');
    chart.setOption(option_value);
  },

  resize: function(el, width, height) {
  }
  
});