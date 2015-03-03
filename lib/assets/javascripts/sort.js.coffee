jQuery ->

  # this is a small hack; when a tr is dragged with jQuery UI sortable
  # the cells lose their width
  # cells = $('.table').find('tr')[0].cells.length
  # desired_width = $('.table').width() / cells + 'px'
  # $('.table td').css('width', desired_width)

  $('#sortable').sortable(
    axis: 'y'
    items: '.item'

    # highlight the row on drop to indicate an update
    stop: (e, ui) ->
      ui.item.children('td').effect('highlight', {}, 1000)
    update: (e, ui) ->
      position = ui.item.index()

      data_transfered = {data: {thing: {}}}
      data_transfered['data']['thing'][ui.item.data('ordered-row')+'_position'] = position

      $.ajax(
        type: 'PUT'
        url: ui.item.data('update-url')
        dataType: 'json'

        data: data_transfered['data']
      )
  )
