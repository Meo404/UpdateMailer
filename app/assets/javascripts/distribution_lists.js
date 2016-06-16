/*
    Selectize setup for distribution lists
    Allows the user to add non-stored email addresses to the list -> They will be persisted in the BE
 */

$(document).ready(function() {
    // TODO- Update Regex. It's currently matching non emails as well
    var REGEX_EMAIL = '([a-z0-9!#$%&\'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&\'*+/=?^_`{|}~-]+)*@' +
        '(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)';

    var select = $('#select-emails').selectize({
        persist: false,
        maxItems: null,
        valueField: 'id',
        labelField: 'address',
        searchField: ['address'],
        render: {
            item: function(item, escape) {
                return '<div>' +
                    (item.address ? '<span class="party">' + escape(item.address) + '</span>' : '') +
                    '</div>';
            },
            option: function(item, escape) {
                var label = item.address;
                return '<div>' +
                    '<span class="party">' + escape(label) + '</span>' +
                    '</div>';
            }
        },
        createFilter: function(input) {
            var match, regex;
            // email@address.com
            regex = new RegExp('^' + REGEX_EMAIL + '$', 'i');
            match = input.match(regex);
            if (match) return !this.options.hasOwnProperty(match[0]);
            return false;
        },
        create: function(input) {
            if ((new RegExp('^' + REGEX_EMAIL + '$', 'i')).test(input)) {
                return {id: input, address: input};
            }
            var match = input.match(new RegExp('^([^<]*)\<' + REGEX_EMAIL + '\>$', 'i'));
            if (match) {
                return {
                    id : match[2],
                };
            }
            alert('Invalid email address.');
            return false;
        }
    });
});
