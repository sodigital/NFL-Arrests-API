$(function(){



  if (window.location.pathname == "/") {
      $( ".typeahead" ).keyup(function() {
        var term = $(this).val();
         fetchQueryResults(  term  )
         if (term){
           history.pushState({id: null}, '', '#'+term);
         } 
      });



    function renderResults(payload){
      var source   = $("#some-template").html();
      var template = Handlebars.compile(source);
      $("#content-placeholder").html(template(payload));
      $( ".typeahead" ).fadeIn()
      initEvents()

      // if (   $(".headerSortDown").length < 1 || $(".headerSortUp").length < 1  ) {
      //   $(".black-bg").removeClass("black-bg")
      //   $(".header").eq(0).addClass("black-bg")
      // } else {
      //   alert("as")
      // }


    }


    function fetchQueryResults(q){
       if(q == ''){
         var url = "http://sd.dev:3007/query"
       } else {
        var url =  "http://sd.dev:3007/query?q="+q
       }
      $.get(url , function( data ) {    
        renderResults(data)
      });
    }  


    function initEvents(){
      $("#myTable").tablesorter(); 

    }  

    if(window.location.hash) {
      var param = window.location.hash.replace("#","")
      $('.typeahead').val(param)
      fetchQueryResults(param)
    } else {
      fetchQueryResults("")
    }

  



 
  }//end if check on path

}); 
