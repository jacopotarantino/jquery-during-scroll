(function(window) {
  'use strict';
  /**
   * @module duringScroll
   */
  function duringScroll(options) {
    var topOffset = 0,
        state = 'not scrolling',
        noop = function() {},
        defaultOptions = {
          interval: 60,
          always: noop,
          scrollStart: noop,
          duringScroll: noop,
          afterScroll: noop
        };
  }


  function handle_scrolling(scrolling, not_scrolling) {
    if(document.body.scrollTop === top_offset) {
      top_offset = document.body.scrollTop;
      not_scrolling ? not_scrolling() : null;

    } else {
      top_offset = document.body.scrollTop;
      scrolling();
    }
  }

  /**
   * @method currently_scrolling
   * @description helper method that invokes functions during and after scroll.
   * @param scrolling - function to execute while scrolling.
   * @param
   */
  function currently_scrolling(scrolling, not_scrolling) {
    setInterval(function() {
      handle_scrolling(scrolling, not_scrolling);
    }, options.interval);
  }


  var hasDefine = typeof window.define === 'function' && window.define.amd,
      hasExports = typeof window.module !== 'undefined',
      hasJquery = typeof window.jQuery !== 'undefined';


  if( hasDefine ) {
    window.define(function() {
      return {
        duringScroll: duringScroll
      };
    });
  }

  if( hasExports ) {
    window.module.exports = duringScroll;
  }

  if( hasJquery ) {
    window.jQuery.duringScroll = duringScroll;
  }

  if( !hasDefine && !hasExports && !hasJquery ) {
    window.duringScroll = duringScroll;
  }

})(window);
