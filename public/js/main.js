$(document).ready(
function()
{
  $("#result").hide();
  $("#tar").submit(function(event){
    event.preventDefault();
    $(this).hide();
    console.log("category is " + $("#cat").val())
    $.post('/',{category: $("#cat").val()},function(response,data){$("#lyric").html(response);});
    $("#result").show();

  });
}
);
