//= require cable
//= require_self
//= require_tree .

this.App = {};

App.cable = ActionCable.createConsumer();

App.messages = App.cable.subscriptions.create('AttendantsChannel', {
  received: function(data) {
    var checkbox = $('.attended[data-id="' + data.id + '"]');
    checkbox.prop('checked', data.attended);
  },
});
