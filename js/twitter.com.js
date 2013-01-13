// ==UserScript==
// @match http://twitter.com/*
// @match http://www.twitter.com/*
// @match https://twitter.com/*
// @match https://www.twitter.com/*
// ==/UserScript==
/*!
 * Name: Twitter Quick View
 * URL: http://tungdao.com
 * Description: Add `v` keyboard shortcut to open the first link in a tweet
 * License MIT (c) 2012 Tung Dao
 */
;(function() {

  if (window.jQuery) {
    init()
  } else {
    window.addEventListener('load', init, false)
  }

  function init() {
    console.log('Twitter Quick View Initialized!')

    // Open first link in current tweet by press `v`
    document.addEventListener('keydown', function(e) {
      if (e.keyCode === 86) {
        try {
          [].filter.call(
              document.querySelector('.hovered-stream-item')
                .querySelectorAll('.js-tweet-text a')
            , function(el) {
                return !el.dataset['screenName']
            }
          )[0].click()
        } catch (e) {}
      }
    }, false)
  }

})();
