// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require jquery_ujs
//= require time_widget

function after_load() {

  // attributes = Trix.config.blockAttributes
  // attributes["heading1"].tagName = "h2"

  $('body').tooltip({selector: '[data-show=tooltip]', container: "body"});
  $('body').popover({selector: '[data-show=popover]', html: true});
  
  $("body").on("change propertychange input paste", ".point-input", function(){
    $(this).closest(".row").removeClass("saved");
    $(this).closest(".row").removeClass("failed");
  });

  // $('a.colorbox').colorbox({scalePhotos: true, maxHeight: "90%", maxWidth: "90%", transition: 'fade'})

}

$(document).on('nested:fieldAdded', function(event){
  after_load();
});

$(function() {
  after_load();
});
