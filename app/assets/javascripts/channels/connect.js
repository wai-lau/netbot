connect = () => {
  App.moves = App.cable.subscriptions.create('MovesChannel', {  
    received: (data) => {
      $('#move-input').val('');
      if (data.text) this.textResponse(data.text); 
      if (data.update) {
	this.renderGrid(data.grid_state);
	this.selectedProgram(
	  data.grid_state.programs[data.grid_state.selected_program] 
	)
      }
      return
    }
  });
}

textResponse = (text) => {
  $('#moves').prepend("<p>" + text + "</p>");
}

selectedProgram = (program) => {
  $('#selected-program').html(
    `
      <p>Name: ${program.name}</p>
      <p>Max Size: ${program.max_size}</p>
      <p>Max Move: ${program.max_move}</p>
      <p>Moves Left: ${program.cur_move}</p>
    `
  )
}
	
renderGrid = (grid_state) => {
  let newGrid = ""
  gs = grid_state
  let types = grid_state.tile_types
  let programs = grid_state.programs
  let sprogram = grid_state.selected_program
  grid_state.reference_map.forEach( (row) => {
    row.forEach( (ref) => {
      newGrid +=
      `
        <div style="background-color: ${backgroundColor(ref, types, programs, sprogram)}" class="tile">
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

backgroundColor = (ref, types, programs, sprogram) => {
  if (types[ref].type == "program") {
    color = programs[types[ref].owner].color
    if (sprogram == types[ref].owner)
      return color + "; opacity: 1;"
    else
      return (programs[types[ref].owner].color)
  } else { 
    return 'white; opacity: 0.3'
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
