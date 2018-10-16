function connect() {
  App.moves = App.cable.subscriptions.create('MovesChannel', {  
    received: function(data) {
      $('#moves').prepend(this.textResponse(data.text));
      if (data.update) this.renderGrid(data.grid_state);
      return
    },
    textResponse: function(text) {
      return "<p>" + text + "</p>";
    },
    renderGrid: function(grid_state) {
      grid_state.forEach( function(row) {
	row.forEach( function(tile) {
          $("#game-grid").append(
	    `
	    <div style="background-color: " class="tile">
	      <p>
	        ${tile}
	      </p>
	    </div>
	    `
	  )
	});
      });
      $("#game-grid").css("grid-template-areas","'" + "a ".repeat(10) + "'")
    }
  });
}
