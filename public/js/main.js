$(document).ready(
  function() {
    $("#result").hide();
    $("#vote_response").hide();
    $("#tar").submit(function(event) {
      event.preventDefault();
      $(this).hide();
      //console.log("category is " + $("#cat").val())
      $.post('/', {
        category: $("#cat").val()
      }, function(response, data) {
        $("#lyric").html(response);
      });
      $("#result").show();
      $("#vote").show();

    });

    $("#again").click(
      function() {
        $("#tar").show();
        $("#result").hide();
        $("#vote_response").hide();

      }
    );

    $("#tar").submit(function(event) {
      event.preventDefault();
      $(this).hide();
      console.log("category is " + $("#cat").val())
      $.post('/', {
        category: $("#cat").val()
      }, function(response, data) {
        $("#lyric").html(response);
      });
      $("#result").show();

    });

    $("#vote div button").click(function(event) {
      event.preventDefault();
      var votes = {
        type: $(this).val()
      };
      console.log(votes);
      $.post('/vote', votes, function(response, data) {
        $("#vote").hide();
        //  $("#result").hide();
        $("#vote_response").show();
        $("#vote_response").html(response);

      });

    });

  }
);
