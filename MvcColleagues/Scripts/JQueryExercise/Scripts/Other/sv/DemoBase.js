/* Author:    Bert Craytor
 * Location:  Pacifica, California, USA
 * Date:      August 2013
 * Purpose:   Demo JQuery Program
 */

/*global $:false */

var DemoBase = DemoBase || {};

DemoBase.SecurityDialogs = function () {
    "use strict";
    this.width = 800;
    this.height = 200;
    this.title = '';
    this.xOffset = 0;
    this.dlg = null;
    this.yOffset = 0;
    this.updatedSecurityControls = false; // Used by the security feature widget to communicate with the level widget
                                          // that it needs to update
    this.features = [];                   // Holds the current list of features
    this.levels = [];                     // Holds the current list of levels for features, - should put into features object ....
    this.border = 'solid 1px #888';
};


DemoBase.SecurityDialogs.prototype = function () {
    "use strict";

    // Just creates a table row for either of the two pop-up tables
    var createTableRow =
        function (columnCount, feature) {
            var col,
                colWidth = '100px',
                featureBorder = 1,
                tblHtml  = "";

            if (columnCount < 2) {
                featureBorder = 0;
                colWidth = 'auto';
            }


            tblHtml = "<tr>";
            tblHtml += "<td  style='border:" + featureBorder + "; margin;0; height:20px; width:'" + colWidth + "'><input class='feature' style='border:0;' type='text' value=" + feature + "></td>";

            for (col = 1; col < columnCount; col = col + 1) {
                tblHtml += "<td style='border:1; padding-left:30px; height:20px;'><input class=" + "'Col" + (col + 1) + "' type='checkbox'; value='false' />";
            }

            tblHtml += "</tr>";
            return tblHtml;
        },

        // This does the minimal to create a dialog (Popup)
        createDialog =
        function (html, title, x, y, minWidth, minHeight) {

            return $(html).dialog({
                zIndex: 3000,
                autoOpen: false,
                show: 'show',
                hide: 'hide',
                width: 'auto',
                title: title,
                position: [x, y],
                minWidth: minWidth,
                minHeight: minHeight,
                maxWidth: minWidth + 100,
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
        },

        // Adds a new row to the features table
        addNewRow =
        function (doc, tableId, featureName) {

            var table = doc.getElementById(tableId),
                row = table.rows[1].cloneNode(true),
                inputs = row.getElementsByTagName('input'),
                i = inputs.length;

            if (featureName === null) {
                featureName = "[enter feature name]";
            }


            while (i--) {

                if (inputs[i].type  === 'text') {

                    inputs[i].value = featureName;


                    // Might want to change other properties too
                }
                if (inputs[i].type  === 'checkbox') {

                    inputs[i].value = false;


                    // Might want to change other properties too
                }
            }

            table.tBodies[0].appendChild(row);
        },

        // This adds a button at the bottom of the table to allow adding new rows
        addNewRowButton =
        function (doc, tableId, dlg, title, x, y, minWidth, minHeight, features, updatedSecurityControls) {
            this.features = features;
            dlg.dialog({buttons : [{text: "New", click: function (e) {
                e.preventDefault();
                e.stopPropagation();
                this.updatedSecurityControls = updatedSecurityControls;
                $(this).dialog('close');
                addNewRow(doc, tableId, null);
                dlg.dialog('open');
            }},

                { text: "Close", click: function (e) {
                    e.preventDefault();
                    e.stopPropagation();
                    this.features = features;
                    this.updatedSecurityControls = updatedSecurityControls;
                    $(this).dialog('close');
                    var table = doc.getElementById(tableId),
                        rowCount = table.rows.length;   // but this includes the header row!


                    this.features.length = 1;  // truncate all but first and rebuild:

                    for ( var row=1; row < rowCount; row++)
                    {
                        this.features[row-1]= table.rows[row].getElementsByTagName('input')[0].value;

                    }

                    var rowList="";
                    for (  row=0; row < rowCount-1; row++)
                    {

                        rowList += this.features[row] + " ";
                    }
                    this.updatedSecurityControls = true;
                }}

                ]});
        },

        // This adds a button at the bottom of the table to allow adding new rows
        addReportLevelsButton =
            function (doc, tableId, dlg, title, x, y, minWidth, minHeight, features, levels) {
                this.features = features   ;
                this.levels = levels;

                // This adds the "Report Security Levels" button
                dlg.dialog({buttons : [{
                        text: "Report Security Levels", click: function (e) {
                        e.preventDefault();
                        e.stopPropagation();
                        this.features= features;
                        $(this).dialog('close');
                        var table = doc.getElementById(tableId),
                            rowCount = table.rows.length;   // but this includes the header row!

                        for ( var row=1; row < rowCount; row++)
                        {
                            var inputs = table.rows[row].getElementsByTagName('input');
                            this.features[row-1]= inputs[0].value;

                            levels[row-1] = -1;

                            for(var index=1;index<inputs.length;index++)
                                {
                                    if (index > 0){
                                        if($(inputs[index]).attr('checked'))
                                        {
                                           levels[row-1] = index;
                                           break;
                                        }


                                    }
                                }

                        }
                        // Report security level setting results:
                        var rowList="";
                        for (  row=0; row < rowCount-1; row++)
                        {
                            if(levels[row] < 0)
                            {
                                continue;
                            }
                            rowList += "Feature: " + this.features[row] + "        Level: " + levels[row] + "+ <br/>";
                        }
                        $("#results").html(rowList);

                    }}

                ]});
            },


    // A "FeatureLevelPopup" contains a table with a feature name in the first column
        // and an arbitrary number of checkboxes to the right, indicating level.
        createFeatureLevelPopup =
        function (doc, tableId, title, columnCount, x, y, addNewButton) {
            this.title = title;
            this.xOffset = x;
            this.yOffset = y;
            var firstFeature = "feature name";

            if (this.features !== null && this.features.length > 0)
            {
                firstFeature = this.features[0];
            }



            var rows,
                col,
                tblHtml = "";  // <script src='Content/Site.css' rel='stylesheet'></script>";

            tblHtml += "<div><table id='" + tableId + "'><thead><tr><th style='width:100px'>Feature</th>";

            for (col = 1; col < columnCount; col = col + 1) {
                tblHtml += "<th style='text-align:center'>Level " + col + "</th>";
            }
            tblHtml += "</tr></thead>";
            tblHtml += "<tbody>";

            for(var i=0; i < this.features.length; i++)
            {
                tblHtml += createTableRow(columnCount, this.features[i]);
            }
            tblHtml += "</tbody></table></div>";

            this.dlg =  createDialog(tblHtml, this.title, this.xOffset, this.yOffset, this.minWidth, this.minHeight);

             // Add handlers for cell click
            $('td').click(function (e) {

               var  rowIndex =  $(this).parent().parent().children().index($(this).parent()),
                    colIndex = $(this).parent().children().index($(this)),
                    table,
                    row,
                    inputs,
                    nbrChkBoxes;

                if (colIndex > 0) {
                    table = doc.getElementById(tableId);
                    row = table.rows[rowIndex+1];
                    inputs = row.getElementsByTagName('input');
                    nbrChkBoxes = inputs.length - 1;

                    $.each(inputs, function (index, in1) {
                        if(index > 0) {

                            if (index < colIndex ) {
                                $(in1).attr('checked',false);
                            } else {
                                if(colIndex < nbrChkBoxes) {
                                    $(in1).attr('checked',true);
                                }
                            }

                        }

                    });
                }


            });

            return this.dlg;
        },

        drawRectangle =
        function drawrectangle(doc,  parent, top, left, width, height ,step, color )
        {
            if(color > 15 || width < 2* step) {
                return ;     // end the recursion
            }

            var rect = $("<div/>", {} ) ;
            var hex = color.toString(16);
            var hexColor = '#' + hex+hex+hex;

            rect.css( { "position": "relative", "margin":"0px","border":"0", "padding":"0px",   "background-color": hexColor, "top": top, "left": left, "width": width, "height": height } );
            rect.appendTo(parent);

            var newWidth= width - 2* step;
            return drawrectangle(doc,  rect, step, step, newWidth,newWidth ,step , color+1);
        }  ,

        drawSquares =
        function (doc, parent, startValue, visibleStepWidth) {

            // Clip startValue to acceptable range
            if(startValue > 14) { startValue = 14; }
            if(startValue < 0 ) { startValue= 0; }

            // Clip visibleStepWidth to reasonable range:
            if(visibleStepWidth < 0) { visibleStepWidth = 0; }
            if(visibleStepWidth > 500) { visibleStepWidth = 500; }

            var totalWidth = 15*visibleStepWidth*2;

            if(totalWidth > 1000)
               { visibleStepWidth = 1000/30; }

            var numberOfSteps= (15-startValue);

            var width = numberOfSteps*visibleStepWidth*2;

            drawRectangle(doc, parent, 0, 0, width, width,visibleStepWidth, startValue  ) ;

        };



    return {
        createFeatureLevelPopup : createFeatureLevelPopup, // Part I of Exercise
        addReportLevelsButton   : addReportLevelsButton,   // Part I of Exercise
        addNewRowButton         : addNewRowButton,         // Part I of Exercise
        drawSquares             : drawSquares              // part II of exercise
    };
}();
