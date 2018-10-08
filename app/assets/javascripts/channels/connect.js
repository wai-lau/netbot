function connect() {
  App.moves = App.cable.subscriptions.create('MovesChannel', {  
    received: function(data) {
      return $('#moves').prepend(this.renderMove(data));
    },
    renderMove: function(data) {
      return "<p>" + data.move + "</p>";
    }
  });
}
