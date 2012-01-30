/*
 * jQuery / jQuery UI Dialog Plugin
 * Copyright 2011, Charter Communications
 *
 * This plugin makes the use of jQuery UI dialogs easier.
 *
 * Usage:
 *
 * // open dialog
 * $.dialog().open( <options> );
 *
 * // open dialog as status
 * $.dialog().open_as_status( <options> );
 * 
 * // close dialog
 * $.dialog().close();
 *
 * // set content
 * $.dialog().content.html( <html> )
 *
 * // set error content
 * $.dialog().error.html( <html> )
 *
 * // show loading animation
 * $.dialog().load_start();
*/
(function(jQuery){

  jQuery.extend({
    dialog:function( methodName, options ) {
      var id = 'dialog2';
      var el = $('#' + id);

      // create dialog if it does not exist
      if ( el[0] === undefined ) {
        el = init();
      }

      if ( methodName !== undefined && options !== undefined ) {
        el.dialog( methodName, options );
      } else if ( methodName !== undefined ) {
        el.dialog( methodName );
      }

      var error_element   = el.find('.error');
      var content_element = el.find('.content');
      var loading_element = el.find('.loading-animation');

      // expose methods on error element:
      // $.dialog().error.message('<p>Corge</p>'); //=> set error message
      // $.dialog().error.reset();  //=> empty error message
      error_element.extend({
        reset: function() {
          error_element.empty().hide();
        },
        message: function( message ) {
          error_element.html( message );
          error_element.show();
        }
      });

      // expose methods on dialog element
      // $.dialog().error //=> error element
      // $.dialog().content //=> content element
      // $.dialog().open() // => open dialog
      el.extend({
        content: content_element,
        error: error_element,
        load_start: function() {
          // ignore if dialog is not open
          if ( !el.is_open() ) { return el; }

          error_element.reset();
          content_element.hide();
          loading_element.show();
          return el;
        },
        load_stop: function() {
          // ignore if dialog is not open
          if ( !el.is_open() ) { return el; }

          loading_element.hide();
          content_element.show();
          return el;
        },
        open: function( methodName, options ) {

          if ( methodName !== undefined && options !== undefined ) {
            el.dialog( methodName, options );
          } else if ( methodName !== undefined ) {
            el.dialog( methodName );
          }

          error_element.reset();
          content_element.show();
          loading_element.hide();
          el.dialog('option', { buttons: {} });
          el.dialog('open');
          return el;
        },
        open_as_status: function( methodName, options ) {
          el.open( methodName, options ).buttons({
            "Close":{ 'text':'Close', 'class':'btn', 'click':function() { el.close(); } }
          });
          return el;
        },
        close: function() {
          el.dialog('close');
          return el;
        },
        buttons: function( button_object ) {
          el.dialog( "option", { buttons: button_object } );
        },
        is_open: function() {
          return el.is(':visible');
        }
      });

      return el;

      // initialize dialog elements
      function init() {
        $('body').append(
          '<div id=\"' + id + '\" style=\"display:none\">' +
          '<div class=\"error alert-message block-message\" style=\"display:none;\"></div>' +
          '<div class=\"content\"></div>' +
          // Set spinner image alignment as center.
          '<div class=\"loading-animation\" style=\"line-height:100px;  text-align:center; width:100%; display:none;\">' +
          '<img src="/images/page-loading.gif" alt="Please wait..." align="absmiddle"/>' +
          '</div>' +
          '</div>'
        );

        var el = $('#'+id);

        // initialize dialog
        el.dialog({
          autoOpen: false,
          width: "475",
          overflow:"hidden",
          modal: true,
          resizable: false,
          hide: {
            effect: "fadeOut",
            duration: 500
          }
        });

        // bind events for dialog
        $(document).unbind('dialogclose');

        $(document).bind('dialogclose', function( e, ui ) {
          $.dialog().error.reset();
          $.dialog().content.empty();
          $.dialog().load_stop();
          //console.log('dialog closed');
        });

        //console.log('dialog initialized.');

        return el;
      } // init
    }
  });

})( jQuery );

