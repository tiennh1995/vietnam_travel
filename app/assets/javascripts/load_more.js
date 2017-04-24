$(document).on('click', '.load-more',function() {
  if($(this).prev().is(':visible')) {
    $(this).text('もっと見る..');
    $(this).prev().hide();
  } else {
    $(this).text('縮める..');
    $(this).prev().show();
  }
});
