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

$(document).ready(function(){
  showPagesPerCat();
});