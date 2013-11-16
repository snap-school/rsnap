$ ->
  $('.popover-default').popover(html: true)

# hidde popover when we click outside of them
$ ->
  $('body').on 'click', (e)->
    $('.popover-default').each ->
        if (not $(this).is(e.target) and $(this).has(e.target).length == 0 and $('.popover').has(e.target).length == 0)
          $(this).popover('hide');
