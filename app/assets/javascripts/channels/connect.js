function connect() {
  App.moves = App.cable.subscriptions.create('MovesChannel', {  
    received: function(data) {
      $('#moves').prepend(this.textResponse(data));
      this.renderGrid(data);
      return
    },
    textResponse: function(data) {
      return "<p>" + data.text + "</p>";
    },
    renderGrid: function(data) {
      $("#game-grid").css("grid-template-areas","'" + "a ".repeat(9) + "'")
    }
  });
}
