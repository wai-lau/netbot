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
  let types = grid_state.tile_types
  let programs = grid_state.programs
  grid_state.reference_map.forEach( (row) => {
    row.forEach( (ref) => {
      newGrid +=
      `
        <div style="background-color: ${backgroundColor(ref, types, programs)}" class="tile">
          <p>
  	    ${letterLabel(ref, types, programs)}
          </p>
        </div>
      `
    });
  });
  $("#game-grid").css("grid-template-areas","'" + "a ".repeat(grid_state.reference_map[0].length) + "'")
  $("#game-grid").html(newGrid);
}

backgroundColor = (ref, types, programs) => {
  if (types[ref].type == "program") {
    return (programs[types[ref].owner].color)
  } else { 
    return 'light-grey; opacity: 0.1'
  }
}

letterLabel = (ref, types, programs) => {
  if (types[ref].head) {
    if (types[ref].type == "program"){
      return (programs[types[ref].owner].name[0])
    } else {
      return ("")
    }
  } else {
    return ("")
  }
}
