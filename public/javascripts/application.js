// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(
  (function( $ ) {
    $.widget( "ui.combobox", {
      _create: function() {
        var self = this,
        select = this.element.hide(),
        selected = select.children( ":selected" ),
        value = selected.val() ? selected.text() : "";
        var dropDownId = select.attr("id");
        var input = this.input = $( "<input id='"+dropDownId+"_text'>" )
        .insertAfter( select )
        .val( value )
        .autocomplete({
          delay: 0,
          minLength: 0,
          source: function( request, response ) {
            var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
            response( select.children( "option" ).map(function() {
              var text = $( this ).text();
              if ( this.value && ( !request.term || matcher.test(text) ) )
                return {
                  label: text.replace(
                    new RegExp(
                      "(?![^&;]+;)(?!<[^<>]*)(" +
                      $.ui.autocomplete.escapeRegex(request.term) +
                      ")(?![^<>]*>)(?![^&;]+;)", "gi"
                      ), "<strong>$1</strong>" ),
                  value: text,
                  option: this
                };
            }) );
          },
          select: function( event, ui ) {
            ui.item.option.selected = true;
            self._trigger( "selected", event, {
              item: ui.item.option
            });
          },
          change: function( event, ui ) {
            if ( !ui.item ) {
              var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( $(this).val() ) + "$", "i" ),
              valid = false;
              select.children( "option" ).each(function() {
                if ( $( this ).text().match( matcher ) ) {
                  this.selected = valid = true;
                  return false;
                }
              });
              if ( !valid ) {
                // remove invalid value, as it didn't match anything
                $( this ).val( "" );
                select.val( "" );
                input.data( "autocomplete" ).term = "";
                return false;
              }
            }
          }
        })
        .addClass( "ui-widget ui-widget-content ui-corner-left" );

        input.data( "autocomplete" )._renderItem = function( ul, item ) {
          return $( "<li></li>" )
          .data( "item.autocomplete", item )
          .append( "<a>" + item.label + "</a>" )
          .appendTo( ul );
        };

        this.button = $( "<button type='button'>&nbsp;</button>" )
        .attr( "tabIndex", -1 )
        .attr( "title", "Show All Items" )
        .insertAfter( input )
        .button({
          icons: {
            primary: "ui-icon-triangle-1-s"
          },
          text: false
        })
        .removeClass( "ui-corner-all" )
        .addClass( "ui-corner-right ui-button-icon" )
        .click(function() {
          // close if already visible
          if ( input.autocomplete( "widget" ).is( ":visible" ) ) {
            input.autocomplete( "close" );
            return;
          }

          // work around a bug (likely same cause as #5265)
          $( this ).blur();

          // pass empty string as value to search for, displaying all results
          input.autocomplete( "search", "" );
          input.focus();
        });
      },

      destroy: function() {
        this.input.remove();
        this.button.remove();
        this.element.show();
        $.Widget.prototype.destroy.call( this );
      }
    });
  })( jQuery )



  );
/* $(function() {
    $("#patient_test_execution_date").datepicker();
    $("#patient_test_delivery_date").datepicker();
  });
/*
	$(function() {
		$( "#combobox" ).combobox();
		$( "#toggle" ).click(function() {
			$( "#combobox" ).toggle();
		});
	});*/
function setChangeEvent(Id){
  $("#"+Id).change( function() {
    var catId;
    if(  $(this).val() == "")
      catId = 0;
    else
      catId     = $(this).val()
    $.ajax({
      url: '/test_categories/'+catId+'/tests',
      type: "GET"
    });
  });
  return false;
}
// Close dialog box
function closeDialog(){
  $.dialog().close();
  return true;
}

function addTest() {
  var testId = $('#test_name_id').val();
   $.ajax({
      url: '/patients/'+testId+'/add_test',
      type: "GET"
    });
}

$(document).ready (function( $ ) {
  // Search button enable only when search field has value.
  $('#patients_list_doctor_search_btn').attr("disabled",true);
  $("#search_from_date").change(function(){
    if($("#search_to_date").val().length > 0  && $("#search_from_date").val().length > 0 ){
      $('#patients_list_doctor_search_btn').attr("disabled",false);
    }
  });
  $("#search_to_date").change(function(){
    if($("#search_to_date").val().length > 0  && $("#search_from_date").val().length > 0 ){
      $('#patients_list_doctor_search_btn').attr("disabled",false);
    }
  });

 // Set advance text field value form check boxbutton
  $("#patient_is_doctor_receoved_payment").click(function() {
    // If checked
    if ($("#patient_is_doctor_receoved_payment").is(":checked"))	{
      $("#patient_advance_payment").val('');
      $("#patient_advance_payment").attr("disabled", true);
    } else {
      $("#patient_advance_payment").removeAttr("disabled");
      }
  });
});


function isNumber(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}

// method to redirect to nested resoure of test categories test from test management page.
function categoryTest(){
  var category_id = $("#category_id").val();
  window.location.href = "/test_categories/" +category_id +"/tests";
}