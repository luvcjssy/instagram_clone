/* Load image after choosing */
var loadFile = function(event) {
  var output = document.getElementById('image-preview');
  output.src = URL.createObjectURL(event.target.files[0]);
};

$( document ).ready(function() {
  /* Load more comments */
  $('.more-comments').click( function() {
    $(this).on('ajax:success', function(event, data, status, xhr) {
      var postId = $(this).data("post-id");
      $("#comments_" + postId).html(data);
      $("#comments-paginator-" + postId).html("<a id='more-comments' data-post-id=" + postId + "data-type='html' data-remote='true' href='/posts/" + postId + "/comments>show more comments</a>");
    });
  });

  /* Remove pagination if number of images not greater than 10 items */
  if (!$('#load_more').length) { $('#paginator').remove(); }
});
