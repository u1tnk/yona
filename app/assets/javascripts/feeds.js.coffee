$ ->
  index = $(".index")
  feed_links = index.find('a.feed_link')
  feed_links.on(
    'ajax:success'
    (data, res, xhr) ->
      index.find('#articles').html(res)
      index.find('#contents').children().remove()

      index.find('a.article_link').click ->

        self = $(this)
        index.find('a.article_link').removeClass('focused')
        self.addClass('focused')

        self.addClass('readed')

        unless self.hasClass('readed')
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

  KEYCODE_H = 72
  KEYCODE_J = 74
  KEYCODE_K = 75
  KEYCODE_L = 76
  $('*').bind 'keydown', (e) ->
    console.log e.keyCode

  feed_links.first().click()

  # faviconが表示できなかったらrssアイコン表示
  favicon = index.find('.favicon')
  favicon.hide()
  alt_rss_icon = $('<i class = "icon-rss"></i>')
  favicon.before(alt_rss_icon)

  favicon.bind 'load', ->
    $(this).show()
    $(this).prev().hide()


