# jQuery ->
#   if $('#infinite-scrolling').size() > 0
#     $(window).on 'scroll', ->
#       more_profiles_url = $('#infinite-scrolling .next_page a').attr('href')
#       if more_profiles_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
#         $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..."/>')
#         $.getScript more_profiles_url, ->
#       return
#   return


$ ->
  if $('#infinite-scrolling').size() > 0
    $(window).on 'scroll', ->
      more_profiles_url = $('.pagination a[rel=next]').attr('href')
      if more_profiles_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
          $('.pagination').html("")
          $.ajax
            url: more_profiles_url
            success: (data) ->
              $("#my-profiles").append(data)
      if !more_profiles_url
        $('.pagination').html("")
    return
