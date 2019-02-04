$(document).ready(function() {
  $(".attended").click(function() {
    var checkbox = $(this)
    $.ajax({
      url: $(this).data( "url" ),
      method: 'PUT',
      data: JSON.stringify({attendant:{ attended: $(this).prop('checked') }}),
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      error: function(_, _, _){
        checkbox.prop('checked', !checkbox.prop('checked'));
        alert("Oops, something went wrong. Please check your Internet connection.")
      },
    })
  });
});
