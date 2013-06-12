$ ->
  index = $(".index")
  feed_links = index.find('a.feed_link')
  feed_links.on(
    'ajax:success'
    (data, res, xhr) ->
      index.find('#articles').html(res)
      index.find('#contents').children().remove()

      index.find('a.article_link').click ->
        unless $(this).hasClass('readed')
          unread_articles_count = feed_links.filter('.focused').find('.unread_articles_count')
          unread_articles_count.text(parseInt(unread_articles_count.text()) - 1)


      index.find('a.article_link').on(
        'ajax:success'
        (data, res, xhr) ->
          index.find('#contents').html(res)
          $(this).addClass('readed')
      )
  )
  feed_links.click ->
    feed_links.removeClass('focused')
    $(this).addClass('focused')



