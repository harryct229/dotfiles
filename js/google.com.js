// ==UserScript==
// @match http://google.com/*
// @match http://www.google.com/*
// @match https://google.com/*
// @match https://www.google.com/*
// ==/UserScript==
/*!
 * Name: Google Personal
 * Author: Tung Dao <me@tungdao.com>
 * URL: http://tungdao.com
 * Description: Google hacks
 *  - Reader: larger text, hide clutter
 */
/*jshint strict: false, jquery: true*/
;(function() {

  function init() {
    console.log('Google Personal Initialized!')

    $('#viewer-header-container').css({ display: 'none' })
    $('.entry-body .item-body').css({
        'font-size': 16
      , 'line-height': '1.5em'
    })
  }

  if (window.jQuery) {
    init()
  } else {
    window.addEventListener('load', init, false)
  }

}());

