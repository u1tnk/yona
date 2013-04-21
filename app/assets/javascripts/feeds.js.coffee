$ ->
  index = $(".index")
  index.find('a.feed_link').on(
    'ajax:success'
    (data, res, xhr) ->
      index.find('#articles').html(res)
      index.find('a.article_link').on(
        'ajax:success'
        (data, res, xhr) ->
          index.find('#contents').html(res)
      )
  )


