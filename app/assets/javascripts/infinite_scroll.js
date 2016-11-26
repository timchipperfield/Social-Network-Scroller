$(function() {
  if ($('#infinite-scrolling').size() > 0) {
    $(window).on('scroll', function() {
      var more_profiles_url;
      more_profiles_url = $('.pagination a[rel=next]').attr('href');
      if (more_profiles_url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
        $('.pagination').html("");
        $.ajax({
          url: more_profiles_url,
          success: function(data) {
            return $("#feed").append(data);
          }
        });
      }
      if (!more_profiles_url) {
        return $('.pagination').html("");
      }
    });
  }
});
