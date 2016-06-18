/**
 * Created by maurice.vogel on 15/06/16.
 *
 * Javascript to handle table updates via AJAX calls
 */
$(function() {
    $("#data-table").on("click", 'th a', function() {
        $.getScript(this.href);
        return false;
    });
    $("#data-table").on("click", '.pagination a', function() {
        $.getScript(this.href);
        return false;
    });
    $(".own-mails-switch").change(function() {
        $('#search-field').submit();
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