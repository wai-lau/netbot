function connect() {
  App.moves = App.cable.subscriptions.create('MovesChannel', {  
    received: function(data) {
      $('input').val(''); 
      $('#moves').prepend(this.textResponse(data.text));
      if (data.update) this.renderGrid(data.grid_state);
      return
    },
    textResponse: function(text) {
      return "<p>" + text + "</p>";
    },
    renderGrid: function(grid_state) {
      $("#game-grid").css("grid-template-areas","'" + "a ".repeat(grid_state.length) + "'")
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
    }
  });
}
