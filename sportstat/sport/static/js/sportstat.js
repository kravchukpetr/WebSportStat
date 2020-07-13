
//Добавление подсветки для места в турнирной таблице в зависимости от
//попадания в одну из зон: ЛЧ, ЛЕ, зона вылета
 $(document).ready(function(){
   $("td.StandPosType1").addClass('pos_type_chl');
   $("td.StandPosType2").addClass('pos_type_le');
   $("td.StandPosType3").addClass('pos_type_out');

   $("td.ResultWinLoose1").addClass('pos_type_chl');
   $("td.ResultWinLoose2").addClass('pos_type_out');

 });

$(document).ready(function(){
  //Делаем кликабельной всю строку в таблице
  $('tr[data-href]').on("click", function() {
      document.location = $(this).data('href');
  });

  //Свертывание и разворачивание таблиц прогнозов по лигам
  // $(".header").click(function () {
  //   console.log("header click");
  //   $(this).find('.content').toggle();
  // });
});

//Подсветка строки в таблице, на которой активна мышь
$(document).ready(function(){
    $( "#SportTable tbody tr" ).on("mouseover", function( event ) {
        $( this ).addClass('StandSportRowActive');
    });
});

$(document).ready(function(){
    $( "#SportTable tbody tr" ).on("mouseout", function( event ) {
        $( this ).removeClass('StandSportRowActive');
    });
});


// $(document).ready(function(){
//     $( "#StandingDiv tbody tr td" ).on( "click", function( event ) {
//         console.log("click!!!");
//         $(this).tooltip();
//     });
// });

//Переключения между tab вкладками на странице
$('.cont').click(function(){
  var nextId = $(this).parents('.tab-pane').next().attr("id");
  $('[href=#'+nextId+']').tab('show');
});