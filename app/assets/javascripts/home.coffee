$(document).on 'click', '[data-behavior~=crawl_btn]', () ->
  $('#crawl_result').replaceWith('<h4 id="crawl_result">Loading...</h4>')
