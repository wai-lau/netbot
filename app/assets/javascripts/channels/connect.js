connect = () => {
  App.moves = App.cable.subscriptions.create('MovesChannel', {  
    received: (data) => {
      $('#move-input').val('');
      if (data.text) this.textResponse(data.text); 
      if (data.update) this.renderGrid(data.grid_state);
      return
    }
  });
}

textResponse = (text) => {
  $('#moves').prepend("<p>" + text + "</p>");
}
	
renderGrid = (grid_state) => {
  let newGrid = ""
  gs = grid_state
  grid_state.forEach( (row) => {
  row.forEach( (tile) => {
    newGrid +=
      `
      <div style="background-color: ${tile.owner && tile.owner.color ? tile.owner.color : 'light-grey; opacity: 0.1'}" class="tile">
        <p>
  	  ${tile.head && tile.owner && tile.owner.name[0] ? tile.owner.name[0] : ""}
        </p>
      </div>
      `
    });
  });
  $("#game-grid").css("grid-template-areas","'" + "a ".repeat(grid_state[0].length) + "'")
  $("#game-grid").html(newGrid);
}

