function connect() {
  App.moves = App.cable.subscriptions.create('MovesChannel', {  
    received: function(data) {
      $('#move-input').val(''); 
      $('#moves').prepend(this.textResponse(data.text));
      if (data.update) this.renderGrid(data.grid_state);
      return
    },
    textResponse: function(text) {
      return "<p>" + text + "</p>";
    },
    renderGrid: function(grid_state) {
      newGrid = ""
      grid_state.forEach( function(row) {
	row.forEach( function(tile) {
          newGrid +=
	    `
	    <div style="background-color: ${tile.color}" class="tile">
	      <p>
	        ${tile.type}
	      </p>
	    </div>
	    `
	});
      });
      $("#game-grid").css("grid-template-areas","'" + "a ".repeat(grid_state[0].length) + "'")
      $("#game-grid").html(newGrid);
    }
  });
}
