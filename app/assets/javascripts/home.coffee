$(document).on 'click', '[data-behavior~=crawl_btn]', () ->
  $('#crawl_result').replaceWith('<h3 id="crawl_result">Loading...</h3>')
