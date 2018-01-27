//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap-sprockets
//= require chartkick
//= require turbolinks
//= require_tree
window.setTimeout(function() {
    $(".alert").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove();
    });
}, 4000);
