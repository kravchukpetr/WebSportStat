
// var base = document.getElementById('#StandingDiv'); // the container for the variable content
// var selector = '.ResultClassWin'; // any css selector for children

// if(base){
// base.addEventListener('click', function(event) {
//   var closest = event.target.closest(selector);
//   if (closest && base.contains(closest)) {
//     console.log('ResultClassWin');
//     alert( "Handler for .click() called." );
//   }
// })
// };
$(document).ready(function(){
    $( "#StandingDiv tbody tr td" ).on( "click", function( event ) {
        console.log("click!!!");
        $(this).tooltip();
    });
});

$('.cont').click(function(){
  var nextId = $(this).parents('.tab-pane').next().attr("id");
  $('[href=#'+nextId+']').tab('show');
});

$(function() {
  console.log("Hello world!");
  //$('td:contains("2")').addClass('green');
  //document.querySelectorAll('.StandPos').className += " red";
  // var element = document.getElementById("StandPos");
  // element.classList.add("mystyle");

    // if($('.StandPos').val() =='1' ) {
    //       $('.StandPos').addClass('green');
    // }
    // if($('.StandPos').val() =='2' ) {
    //       $('.StandPos').addClass('red');
    // }
 //    var var1 = 1;
	// var var2 = 4;

 //    console.log(var1);
 $(".StandPosType1").addClass('pos_type_chl');
 $(".StandPosType2").addClass('pos_type_le');
 $(".StandPosType3").addClass('pos_type_out');
 //$(".ResultClassWin").addClass(' result_type_win');
 //$(".ResultClassLose").addClass(' result_type_lose');
 

    $(".StandPos").each(function(){
        if(parseInt($(this).text())>=var1  &&  parseInt($(this).text())<=var2){
        	$(this).addClass('red');        	
        }
        if(parseInt($(this).text())>=5 && parseInt($(this).text())<7){
        	$(this).addClass('green');        	
        }
    });

  //$(".StandPos").addClass('green');
    // $(".StandPos").change(function(){
    //    console.log($(this).val());
    //    if ($(this).val() == "3") 
    //       $(".StandPos").addClass('green');
    //    //else $(".StandPos").addClass('red');
    // });
    // $(".StandPos").change(); //call change event when page loads

	// var highlightedItems = document.querySelectorAll('.StandPos');

	// highlightedItems.forEach(function(userItem) {
	// console.log(userItem);
 // 	if (userItem == 1) {
	//  	userItem.className += " red";	 
	//  } else {
	//  	userItem.className += " green";
	//  }
	// });
});