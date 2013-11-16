#= require blueimp-file-upload/js/vendor/jquery.ui.widget
#= require blueimp-file-upload/js/jquery.fileupload

#= require bootstrap-wysihtml5/b3
#= require bootstrap-wysihtml5/locales/fr-FR


$ ->
  $('.wysiwyg').each (i, elem) ->
    $(elem).wysihtml5
      fileUpload:
        url: $(elem).data('url')
        dataType: 'json'
        done: (e, data) ->
          images = []
          response = data.result
          images.push
            src: response.url
            alt: response.name
          return images
      "html": true
      "locale": "fr-FR"
