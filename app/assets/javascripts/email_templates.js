/*
 Method to allow showing preview images for the Template selection
 IF the template selection is a custom template, a textarea to paste the html will be shown
 */
function loadPreview() {
    $('.modal-body').html($('.template-area').val());
}