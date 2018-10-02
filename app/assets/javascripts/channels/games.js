App.moves = App.cable.subscriptions.create('MovesChannel', {  
  received: function(data) {
    $("#moves").removeClass('hidden')
    return $('#moves').append(this.renderMove(data));
  },

  renderMove: function(data) {
    return "<p> <b>" + data.user + ": </b>" + data.move + "</p>";
  }
});
