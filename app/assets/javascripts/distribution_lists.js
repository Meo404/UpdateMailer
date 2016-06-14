$(function() {
    $("#distribution-lists").on("click", 'th a', function() {
        $.getScript(this.href);
        return false;
    });
    $("#distribution-lists").on("click", '.pagination a', function() {
        $.getScript(this.href);
        return false;
    });
    $("#search-field").bindWithDelay("keyup", function() {
        $.get(this.action, $(this).serialize(), null, "script");
        return false;
    }, 250);
    $("#search-field").submit(function(e) {
        e.preventDefault();
        $.get(this.action, $(this).serialize(), null, "script");
        return false;
    })
});