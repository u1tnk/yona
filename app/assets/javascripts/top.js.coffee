top = null
current_kind = null
current_feed = null
current_article = null

key2Command = (e) ->
  press_char = String.fromCharCode e.keyCode
  if e.shiftKey
    press_char
  else
    press_char.toLowerCase()

get_feed_links = ->
  top.find('a.feed_link')

get_article_links = ->
  top.find('a.article_link')

get_next_feed = ->
  feed_links = get_feed_links()
  next_feed_dom = feed_links.get(feed_links.index(current_feed) + 1)
  if next_feed_dom
    $(next_feed_dom)
  else
    feed_links.first()

get_previous_feed = ->
  feed_links = get_feed_links()
  previous_feed_dom = feed_links.get(feed_links.index(current_feed) - 1)
  $(previous_feed_dom) if previous_feed_dom


actionMap = {
  'feed': {
    'j' : ->
      next_feed = get_next_feed()
      next_feed.click() if next_feed
    'k' : ->
      previous_feed = get_previous_feed()
      previous_feed.click() if previous_feed
    'l' : ->
      get_article_links().first().click()
  }
}
# TODO action定義

$(window).keydown (e) ->
  command = key2Command e
  console.log(command)
  action = actionMap[current_kind] && actionMap[current_kind][command]
  action() if action

load_article = (data, res, xhr)->
  top.find('#contents').html(res)
  $(this).addClass('readed')

load_feed = (data, res, xhr)->
  top.find('#articles').html(res)
  top.find('#contents').children().remove()

  article_links = get_article_links()
  article_links.click ->

    current_kind = 'article'
    current_article.removeClass('focused') if current_article
    current_article = $(this)
    current_article.addClass('focused')

    unless self.hasClass('readed')
      unread_articles_count = feed_links.filter('.focused').find('.unread_articles_count')
      unread_articles_count.text(parseInt(unread_articles_count.text()) - 1)

    current_article.addClass('readed')

  article_links.on('ajax:success', load_article)


load_all = (data, res, xhr)->
  top.find('#tags').html(res)
  top.find('#articles').children().remove()
  top.find('#contents').children().remove()

  feed_links = get_feed_links()
  feed_links.click ->
    current_kind = 'feed'
    current_article = null
    current_feed.removeClass('focused') if current_feed
    current_feed = $(this)
    current_feed.addClass('focused')

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



