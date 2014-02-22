import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica 1.0


// Just a simple example to demo both property binding and doing something via pulley menu action
// to provide a sample of Sailfish-specific UI testing
Page {
    id: page

    // Exposing properties for testing. In real app you might like to hide it behind a single interface
    // e.g. via "property variant internals" and then put a QtObject with the individual properties to it
    // @TODO: implement exposing via single internals property
    property alias _subtractMenuAction: subtractMenuAction

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent
        
        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            id: pullDownMenu
            MenuItem {
                id: subtractMenuAction
                text: "Refresh"
                onClicked: {
                    console.log("Refreshing data")

                    var remoteData = new XMLHttpRequest();
                    remoteData.onreadystatechange = function() {
                        if (remoteData.readyState == XMLHttpRequest.HEADERS_RECEIVED) {
                            mainLabel.text = remoteData.getAllResponseHeaders();
                        }
                    }

                    remoteData.open("GET", "http://seravo.fi/");
                    remoteData.send();

                }

            }
        }
        
        // Tell SilicaFlickable the height of its content.
        contentHeight: childrenRect.height
        
        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            anchors.fill: parent
            anchors.margins: Theme.paddingLarge
            spacing: Theme.paddingLarge
            PageHeader {
                title: "Datagatherer"
            }
            Label {
                id: mainLabel
                width: parent.width
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingLarge

                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                textFormat: Text.RichText
                text: "any text here"
            }
        }
    }

}


