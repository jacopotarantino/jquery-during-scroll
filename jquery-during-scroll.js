(function(window) {
  'use strict';
  /**
   * @module TKPL
   * @todo add a string-based state so we can optionally not run a callback more than once during a scroll.
   */

  var top_offset = 0;

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
   * @method TKPL.currently_scrolling
   * @description helper method that invokes functions during and after scroll.
   * @param scrolling - function to execute while scrolling.
   * @param
   */
  window.TKPL.currently_scrolling = function currently_scrolling(scrolling, not_scrolling) {
    setInterval(function() {
      handle_scrolling(scrolling, not_scrolling);
    }, 60);
  };
})(window);




(function() {
  'use strict';
  /**
   * @description Init code to change the opacity of the back-to-top button during scroll.
   */
  $('body').append( $('<style>.back-to-top.scrolling { opacity: 0.6; }</style>') );

  var $back_to_top = $('.js-back-to-top');

  TKPL.currently_scrolling(function() {
    $back_to_top.addClass('scrolling');
  },
  function() {
    $back_to_top.removeClass('scrolling');
  });
})();

