keypress = (url) => {
  $(document).keypress( (event) => {
     $.post( url, {
       "move": {
         "content": String.fromCharCode(event.keyCode)
       }
     })
  });
  $("#move-input").keypress ( (event) => {
    event.stopPropagation();
  });
}
