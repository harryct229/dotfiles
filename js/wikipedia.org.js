// ==UserScript==
// @match http://*.wikipedia.org/*
// @match https://*.wikipedia.org/*
// ==/UserScript==
/*!
 * Name: Wikipedia Personal
 * Author: Tung Dao <me@tungdao.com>
 * URL: http://tungdao.com
 * Description: Wikipedia hacks
 *  - Reader: larger text, hide clutter
 */
;(function() {

  if (window.jQuery) {
    init()
  } else {
    window.addEventListener('load', init, false)
  }

  function init() {
    console.log('Wikipedia Personal Initialized!')

    $('.mw-content-ltr').css({
        'fontSize': 16
      , 'lineHeight': '1.5em'
    })
  }

})();

