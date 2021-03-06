// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery/jquery-2.1.1.js
//= require jquery_ujs
//= require bootstrap-sprockets
//= require selectize
//= require metisMenu/jquery.metisMenu.js
//= require pace/pace.min.js
//= require bindWithDelay/bindWithDelay.js
//= require slimscroll/jquery.slimscroll.min.js
//= require ajaxTable/ajaxTable.js
//= require summernote
//= require inspinia.js
//= require Chart

// FadeOut flash messages
$(document).ready(function () {
    setTimeout("$('.alert').fadeOut('slow')", 2500);
});