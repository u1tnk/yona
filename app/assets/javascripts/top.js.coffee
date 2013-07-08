current_kind = null
current_node = null

key2Command = (e) ->
  press_char = String.fromCharCode e.keyCode
  unless e.shiftKey
    return press_char.toLowerCase()
  press_char

actionMap = {}
# TODO action定義

$(window).keydown (e) ->
  command = key2Command e
  console.log(command)
  action = actionMap[current_kind] && actionMap[kind][command]
  action() if action

top = null

load_article = (data, res, xhr)->
  top.find('#contents').html(res)
  $(this).addClass('readed')

load_feed = (data, res, xhr)->
  top.find('#articles').html(res)
  top.find('#contents').children().remove()

  top.find('a.article_link').click ->

    self = $(this)
    top.find('a.article_link').removeClass('focused')
    self.addClass('focused')
    self.addClass('readed')

    unless self.hasClass('readed')
      unread_articles_count = feed_links.filter('.focused').find('.unread_articles_count')
      unread_articles_count.text(parseInt(unread_articles_count.text()) - 1)

  top.find('a.article_link').on('ajax:success', load_article)


load_all = (data, res, xhr)->
  top.find('#tags').html(res)
  top.find('#articles').children().remove()
  top.find('#contents').children().remove()

  feed_links = top.find('a.feed_link')
  feed_links.click ->
    feed_links.removeClass('focused')
    $(this).addClass('focused')

  feed_links.on('ajax:success', load_feed)
  feed_links.first().click()

$ ->
  top = $(".top")
  refresh_link = top.find('a.refresh_link')

  refresh_link.on('ajax:success', load_all)
  refresh_link.click()

  # faviconが表示できなかったらrssアイコン表示
  favicon = top.find('.favicon')
  favicon.hide()
  alt_rss_icon = $('<i class = "icon-rss"></i>')
  favicon.before(alt_rss_icon)

  favicon.bind 'load', ->
    $(this).show()
    $(this).prev().hide()



