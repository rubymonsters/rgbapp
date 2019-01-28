$(document).ready(function() {
	$(".attended").click(function() {
		$.ajax({
			url: $(this).data( "url" ), 
			method: 'PUT',
			data: JSON.stringify({attendant:{ attended: $(this).prop('checked') }}),
			contentType: "application/json; charset=utf-8",
			dataType: "json",
		})
	});
});

// $(document).ready(function() {
// 	$(".attended").click(function() {
// 		console.log("The checkbox for the attendant number was checked or unchecked");
// 		console.log($(this).prop('checked'));
// 		console.log($(this).attr('data-id'));
// 	});
// });