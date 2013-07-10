SCROLL_MARGIN = 100

top = null
current_kind = null
current_feed = null
current_article = null

feeds_panel = null
articles_panel = null

refresh_link = null

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

get_next = (all, self, diff = 1)->
  next_dom = all.get(all.index(self) + diff)
  if next_dom
    $(next_dom)
  else
    all.first()

clean_read_feeds = ->
  top.find('.unread_articles_count').each (i, unread_articles_count) ->
    unread_articles_count = $(unread_articles_count)
    unread_articles_count.closest('.feed_link').hide() if unread_articles_count.text() == '0'

actionMap = {
  'common': {
    'r': ->
      refresh_link.click()
  },
  'feed': {
    'j' : ->
      next_feed = get_next(get_feed_links(), current_feed)
      if next_feed
        clean_read_feeds()
        feeds_panel.scrollTop(feeds_panel.scrollTop() + next_feed.position().top - SCROLL_MARGIN)
        next_feed.click()
    'k' : ->
      next_feed = get_next(get_feed_links(), current_feed, - 1)
      if next_feed
        clean_read_feeds()
        feeds_panel.scrollTop(feeds_panel.scrollTop() + next_feed.position().top - SCROLL_MARGIN)
        next_feed.click() if next_feed
    'l' : ->
      get_article_links().first().click()
      articles_panel.scrollTop(0)
  },
  'article': {
    'h' : ->
      current_kind = 'feed'
      current_article.removeClass('focused')
      current_article = null
    'j' : ->
      next_article = get_next(get_article_links(), current_article)
      if next_article
        articles_panel.scrollTop(articles_panel.scrollTop() + next_article.position().top - SCROLL_MARGIN)
        next_article.click()
    'J' : ->
      current_article = null
      actionMap['feed']['j']()
    'k' : ->
      next_article = get_next(get_article_links(), current_article, - 1)
      if next_article
        articles_panel.scrollTop(articles_panel.scrollTop() + next_article.position().top - SCROLL_MARGIN)
        next_article.click()
    'K' : ->
      current_article = null
      actionMap['feed']['k']()
    'n' : ->
      # 拡張でvを使うのでここではnとする
      window.open $('.show-original-button').attr('href'), '_blank'
    's' : ->
      console.log('save')
  },
}
# TODO action定義

$(window).keypress (e) ->
  command = key2Command e
  action = (actionMap[current_kind] && actionMap[current_kind][command]) || actionMap['common'][command]
  action() if action

load_article = (data, res, xhr)->
  top.find('#contents').html(res)
  $(this).addClass('readed')

load_feed = (data, res, xhr)->
  top.find('#articles').html(res)
  top.find('#contents').children().remove()

  article_links = get_article_links()
  feed_links = get_feed_links()
  article_links.click ->
    current_kind = 'article'
    current_article.removeClass('focused') if current_article
    current_article = $(this)
    current_article.addClass('focused')

    unless current_article.hasClass('readed')
      unread_articles_count = feed_links.filter('.focused').find('.unread_articles_count')
      console.log unread_articles_count.size()
      unread_articles_count.text(parseInt(unread_articles_count.text()) - 1)

    current_article.addClass('readed')

  article_links.on('ajax:success', load_article)


load_all = (data, res, xhr)->
  top.find('#feeds').html(res)
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
  feeds_panel = top.find('#feeds')
  articles_panel = top.find('#articles')
  refresh_link = top.find('a.refresh_link')

  refresh_link.on('ajax:success', load_all)

  fetch_link = top.find('a.fetch_link')
  fetch_link.on('ajax:success', -> refresh_link.click())
  fetch_link.click()

  # faviconが表示できなかったらrssアイコン表示
  favicon = top.find('.favicon')
  favicon.hide()
  alt_rss_icon = $('<i class = "icon-rss"></i>')
  favicon.before(alt_rss_icon)

  favicon.bind 'load', ->
    $(this).show()
    $(this).prev().hide()



