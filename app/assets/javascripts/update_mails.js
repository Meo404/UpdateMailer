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
            item: function(item, escape) {
                return '<div>' +
                    (item.name ? '<span class="">' + escape(item.name) + '</span>' : '') +
                    '</div>';
            },
            option: function(item, escape) {
                var label = item.name;
                return '<div>' +
                    '<span class="">' + escape(label) + '</span>' +
                    '</div>';
            }
        }
    });
});