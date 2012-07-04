function showPagesPerCat() {
  $('.catlink').each(function(index) { 
    $(this).on("click", function() {
      $('.page').hide();
      $('#page-'+$(this).attr('href').replace(/^#/g, '')).show();
      $('#top').css('background-color',$(this).children().eq(0).css('background-color'));
      $('#headerbg').css('background-color',$(this).children().eq(0).css('background-color'));
    });
  });
}

function addJStoPageLinks() {
  $('div#pages > div > a').each(function(index) { 
     $(this).on("click", function() {
       $.ajax({
         url: $(this).attr('href').replace(/#/g, ''),
         success: function(data) {
            $('#content').html(data);
           }
       });
      }); 
  });
}

function loadPageFromUrl() {
  if ($(location).attr('href').indexOf("#") != -1) {
    $.ajax({
      url: $(location).attr('href').replace(/#/g, ''),
      success: function(data) {
         $('#content').html(data);
        }
    });    
  }
}

function editThisPage() {
  if ($(location).attr('href').indexOf("#") != -1) {
    var getposturl = $(location).attr('href').replace(/#/g, 'source/');
    $.ajax({
      url: getposturl,
      success: function(data) {
         $('#content').html(data);
        }
    });
    $('#edit-button').hide();    
  }
}


$(document).ready(function(){
  showPagesPerCat();
  addJStoPageLinks();
  loadPageFromUrl();
});