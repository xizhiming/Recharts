HTMLWidgets.widget({
  name: 'Eplot',
  type: 'output',

  renderValue: function(el, option_value,  width, height) {
    var chart=echarts.init(el,'macarons');
    chart.setOption(option_value,{
    notMerge: true,
    lazyUpdate: false,
    silent: false
    });
  },

  resize: function(el, width, height) {
  }

});
