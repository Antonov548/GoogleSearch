import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.2

Window{

    id: trayMenu
    visible: false

    flags: "FramelessWindowHint|WindowStaysOnTopHint"

    width: Screen.width/25
    height: btnCloseApplication.height

    color: "transparent"

    property bool showApp: false

    Connections{

        target: trayIcon
        onSignalShowMenu: showTrayMenu(_x,_y)

        function showTrayMenu(_x,_y){

            if(_x > (Screen.width - trayMenu.width)){
                trayMenu.x = _x - trayMenu.width
            }
            else{
                trayMenu.x = _x + 10
            }
            if(_y > Screen.height/2){
                trayMenu.y = _y - trayMenu.height + 10
            }
            else
            {
                trayMenu.y = _y + 20
            }
            if(!trayMenu.visible){
                trayMenu.visible = true
                trayMenu.requestActivate()
            }
        }
    }

    onActiveChanged: activeChange()

    //function trayMenu

    function activeChange(){
        if(!trayMenu.active){
            trayMenu.visible = false
        }
    }

    Rectangle{

        id: btnCloseApplication

        width: parent.width
        height: 25
        color: "#e6e6e6"
        anchors.top: parent.top
        radius: height/12

        Label{

            width: parent.width
            height: parent.height
            text: "CLOSE"
            color: "#007acc"

            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

            font.family: "Arial"
            font.pixelSize: 12
        }

        MouseArea{

            width: parent.width
            height: parent.height

            onClicked: closeApplication()

            function closeApplication(){
                trayIcon.closeApp()
                Qt.quit()
            }
        }
    }
}
