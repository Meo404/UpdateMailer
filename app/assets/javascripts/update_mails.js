/*
 Selectize setup for update mails
 */
$(document).ready(function () {
    var select = $('#select-distribution-lists').selectize({
        persist: false,
        create: false,
        valueField: 'id',
        labelField: 'name',
        searchField: ['name'],
        render: {
            item: function (item, escape) {
                return '<div>' +
                    (item.name ? '<span class="">' + escape(item.name) + '</span>' : '') +
                    '</div>';
            },
            option: function (item, escape) {
                var label = item.name;
                return '<div>' +
                    '<span class="">' + escape(label) + '</span>' +
                    '</div>';
            }
        }
    });

    // Retrieve form id for use on submit events
    var form_id = $('.form-horizontal').attr('id');

    // Save action on new infomail
    $("#submit-button").click(function (e) {
        e.preventDefault();
        $("#update-mail-body").val($("#summernote").code());
        $("#" + form_id).submit()
    });

    // Enable Tooltips
    $('.tooltip-enabled').tooltip();
});

/*
 Method to allow showing preview images for the Template selection
 IF the template selection is a custom template, a textarea to paste the html will be shown
 */
function templateSwitch() {
    var template_preview_id = $('#template-select').val();
    if (template_preview_id == 'custom') {
        $('#preview-image').css('display', 'none');
        $('#custom-template').css('display', 'block')
    } else {
        $('#custom-template').css('display', 'none');
        $('#preview-image').attr('src', '/attachments/store/' + template_preview_id + '/preview_image')
            .css('display', 'block');
    }
}

/*
 Method that will be triggered if the template modal will be submitted.
 Exchanges the current html in the summernote div by the one of the selected template.
 */
function selectTemplate() {
    var html;
    var summernote = $("#summernote");
    var template_id = $('#template-select').find('option:selected').attr('id');


    if (template_id == 'custom') {
        html = $('#custom-html').val()
    } else {
        html = getEmailBody(template_id)
    }
    html.replace(/\<\?xml.+\?\>|\<\!DOCTYPE.+]\>/g, '');

    // Need to close editor before pasting new html into it
    if (summernote.css('display') == 'none') {
        summernote.destroy()
    }
    summernote.html(html);
}

/*
 Method that will do an Ajax Call to get the selected templates html
 @param     template_id     Id of the template to be retrieved
 @return    template body
 */
function getEmailBody(template_id) {
    var template;
    $.ajax({
        url: '/email_templates/templates?id=' + template_id,
        dataType: 'json',
        async: false, // needs to replaced soon with async call!
        success: function (data) {
            template = data.template
        },
        error: function () {
            $('#flash_messages').html("<div class='alert alert-danger'> Selected Template doesn't exist</div>");
            setTimeout("$('.alert').fadeOut('slow')", 2500)
        }
    });
    return template;
}

/*
 Toggles the summernote editor on and off
 */
function toggleSummernote() {
    var summernote = $("#summernote");

    if(summernote.css('display') == 'block') {
        summernote.summernote();
    } else {
        summernote.destroy();
    }
}