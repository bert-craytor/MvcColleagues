/*global $:false */

var DemoBase = DemoBase || {};

DemoBase.Dialogs = function () {
    "use strict";
    this.dialogs = [];  // Dialogs
    this.width = 800;
    this.height = 200;
    this.border = 'solid 1px #888';
};

DemoBase.Dialogs.prototype = function () {
    "use strict";

    var getWidth =
        function getWidth(td) {
            if ($.browser.msie) { return $(td).outerWidth() - 1; }
            if ($.browser.mozilla) { return $(td).width(); }
            if ($.browser.safari) { return $(td).outerWidth(); }
            return $(td).outerWidth();
        },

        prepareTable =
        function prepareTable(table, doc) {
            var tableId = table.attr('id'),

            // wrap the current table (will end up being just body table)
                bodyWrap = table.wrap('<div></div>')
                    .parent()
                    .attr('id', tableId + '_body_wrap')
                    .css({
                        width: this.width,
                        height: this.height,
                        overflow: 'auto'
                    }),

                // wrap the body
                tableWrap = bodyWrap.wrap('<div></div>')
                    .parent()
                    .attr('id', tableId + '_table_wrap')
                    .css({
                        overflow: 'hidden',
                        display: 'inline-block',
                        border: this.border
                    }),

            // clone the header
                headWrap = $(doc.createElement('div'))
                    .attr('Id', tableId + '_head_wrap')
                    .prependTo(tableWrap)
                    .css({
                        width: this.width,
                        overflow: 'hidden'
                    }),

                headTable = table.clone(true)
                    .attr('Id', tableId + '_head')
                    .appendTo(headWrap)
                    .css({
                        'table-layout': 'fixed'
                    }),

                bufferCol = $(doc.createElement('th'))
                    .css({
                        width: '100%'
                    })
                    .appendTo(headTable.find('thead tr'));

            // remove the extra html
            headTable.find('tbody').remove();
            table.find('thead').remove();

            // size the header columns to match the body
            var allBodyCols = table.find('tbody tr:first td');

            headTable.find('thead tr th').each(function (index) {
                var desiredWidth = getWidth($(allBodyCols[index]));
                $(this).css({ width: desiredWidth + 'px' });
            });
        },

        createSecurityTable =
        function (securityLevels) {
            var rows,
                col,
                tblHtml  = "";

            tblHtml = "<tr>";

            for (col = 0; col < securityLevels; col = col + 1) {
                tblHtml += "<td border=1 height=20px>A</td>";
            }

            tblHtml += "</tr>";


            return tblHtml;
        },

        showSecurityTable =
        function (doc, title, securityLevels, x, y) {
            var rows =  createSecurityTable(securityLevels),
                col,
                tableId = "security",
                tblHtml = "";  // <script src='Content/Site.css' rel='stylesheet'></script>";

            tblHtml += "<div><table id='security'><thead><tr><th>Feature</th>";
            for (col = 0; col < securityLevels; col = col + 1) {
                tblHtml += "<th>Level " + col + "</th>";
            }

            tblHtml += "</tr></thead>";
            tblHtml += "<tbody>";
            tblHtml += rows;
            tblHtml += "</tbody></table></div>";
            $(tableId).html(tblHtml);

           // alert(tblHtml);

            var d = $(tblHtml).dialog({
                zIndex: 3000,
                autoOpen: false,
                show: 'show',
                hide: 'hide',
                title: title,
                position: [x, y],
                minWidth: 800,
                minHeight: 100,
                dialogClass: 'dataBox',
                stack: true,
                draggable: true,
                closeOnEscape: true,
                modal: false,
                resizable: true,
                create: function (event, ui) {
                    $('.ui-dialog').wrap('<div class="demo1" />');
                },
                open: function (event, ui) {
                    $('.ui-widget-overlay').wrap('<div class="demo1" />');
                },
                close: function (event, ui) {
                    $(".demo1").filter(function () {
                        if ($(this).text() === "") {
                            return true;
                        }
                        return false;
                    }).remove();
                }
            });

            var tbl = doc.getElementById('security');
            prepareTable(tbl, doc);
            return d;
        },

        createNestedRect =              tbl
        function ( msg, title, x, y) {

            var msgHtml = "<div id='MvcColData'>";
            msgHtml = msgHtml + msg;
            msgHtml = msgHtml + "</div>";

            return $(msgHtml).dialog({
                zIndex: 3000,
                autoOpen: true,
                show: 'show',
                hide: 'hide',
                title: title,
                position: [x, y],
                minWidth: 400,
                minHeight: 100,
                dialogClass: 'dataBox',
                stack: true,
                draggable: true,
                closeOnEscape: true,
                modal: false,
                resizable: true
            });

        };

    return {
        createSecurityTable : createSecurityTable,
        showSecurityTable   : showSecurityTable,
        createNestedRect    : createNestedRect

    };
}();
