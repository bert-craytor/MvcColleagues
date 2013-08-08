/* Author:  Bert Craytor
 * Date:    July 2013
 * Purpose: Demo Program based on Inteview Exercise
 */

var MvcCol = MvcCol || {};

MvcCol.Dialogs = function () {
    this._dialogs = [];  // Dialogs  
    
};

MvcCol.Dialogs.prototype = function () {

    createDataDialog =
            function (msg, title, x, y) {
                var msgHtml = "<div id='MvcColData'>";
                msgHtml = msgHtml + msg;
                msgHtml = msgHtml + "</div>";

                return $(msgHtml).dialog({
                    zIndex: 3000,
                    autoOpen: true,
                    show: 'show',
                    hide: 'hide',
                    title: title,
                    position: [x,y],
                    minWidth: 400,
                    minHeight: 100,
                    dialogClass: 'dataBox',
                    stack: true,
                    draggable: true,
                    closeOnEscape: true,
                    modal: false,
                    resizable: true,
                });
             
        };

   
    return {
        createDataDialog: createDataDialog

    };
}();