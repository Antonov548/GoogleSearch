import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0

Window {

    id: appWindow

    visible: false

    width: 300
    height: 40

    x: Screen.width/2 - width/2
    y: Screen.height/2


    flags: "Window | FramelessWindowHint | WindowStaysOnTopHint"

    color: "transparent"

    Connections{

        target: trayIcon

        onSignalShow: showApplication()

        function showApplication(){

            if(!appWindow.visible){
                appWindow.visible = true
            }
            moveDefault.running = true
        }
    }

    SequentialAnimation{

        id: hideApplication
        running: false

        PropertyAction {
            target: textField; property: "visible"; value: false }

        ParallelAnimation{

            NumberAnimation {
                target: rectMain
                property: "opacity"
                to: 0
                duration: 300
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: listView
                property: "opacity"
                to: 0
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }

        PropertyAction {
            target: appWindow; property: "visible"; value: false }
        PropertyAction {
            target: textField; property: "visible"; value: true }
        PropertyAction {
            target: rectMain; property: "opacity"; value: 1 }
        PropertyAction {
            target: listView; property: "opacity"; value: 1 }

    }

    Rectangle{

        id: rectMain

        visible: true

        width: parent.width
        height: 40

        z: 1

        border.color: "#009900"
        border.width:0

        radius: 4

        property bool enterPressed: false

        color: "#e6e6e6"

        anchors.top: parent.top

        Keys.onDownPressed: onDown()
        Keys.onUpPressed: onUp()
        Keys.onReturnPressed: onEnter()

        /* fucntions keys pressed */

        function onDown(){

            if(listView.visible && listView.currentIndex != listModel.count){

                listView.previousIndex = listView.currentIndex

                listView.currentIndex +=1

                listView.currentIndexEnter = listView.currentIndex

                if(listView.currentIndex>6)
                    scrollBar.increase()
            }
        }
        function onUp(){

            if(listView.visible && listView.currentIndex != 0){
                listView.previousIndex = listView.currentIndex
                listView.currentIndex -= 1
                listView.currentIndexEnter = listView.currentIndex
                if(listView.currentIndex<5)
                    scrollBar.decrease()
            }
        }

        function onEnter(){

            rectMain.enterPressed = true
            if(listView.currentIndexEnter!=0)
                textField.text = listModel.get(listView.currentIndexEnter-1).text
            listView.currentIndexEnter = 0
            listView.closeListView()
            googleApi.openUrl(textField.text)
        }

        ParallelAnimation{

            id: moveDefault
            running: false

            NumberAnimation {
                target: appWindow
                property: "x"
                to: Screen.width/2 - appWindow.width/2
                duration: 300
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: appWindow
                property: "y"
                to: Screen.height/2
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }

        TextField{

            id: textField

            width: parent.width * (3/4)
            height: parent.height - parent.border.width*2

            anchors.left: parent.left
            anchors.leftMargin: parent.border.width
            anchors.verticalCenter: parent.verticalCenter

            font.family: "Arial"
            font.pointSize: 12

            color: "#404040"
            placeholderText: "Search"
            background: Rectangle{
                id: backTextField
                radius: 4
                width: parent.width
                height: parent.height

                color: "#e6e6e6"
            }

            onEditingFinished: editFinished()
            onTextChanged: textChanged()

            /* functions for textField */

            function editFinished(event){
                rectMain.border.width = 0
                textField.focus = false
                listView.visible = false
                appWindow.height = rectMain.height
                listView.closeListView()
            }

            function textChanged(){
                listView.firstOpen = false
                if(!listView.visible && textField.length!=0 && !rectMain.enterPressed){

                    listView.visible = true
                    listView.firstOpen = true
                    googleApi.textChanged(textField.text)

                }else if(textField.length != 0){
                    googleApi.textChanged(textField.text)
                }

                if(textField.length==0 && !moveApp.checkDoubleClicked){
                    listView.visible = false
                    appWindow.height = rectMain.height
                    listView.closeListView()
                }
                moveApp.checkDoubleClicked = false
                rectMain.enterPressed = false
            }
        }

        MouseArea{

            id: moveApp

            property real startPositonX: 0
            property real startPositonY: 0
            property bool checkPressed: false
            property bool checkDoubleClicked: false

            width: parent.width
            height: parent.height

            hoverEnabled: true

            onPositionChanged: mouseChangePosition()
            onPressed: mousePressed()
            onReleased: mouseReleased()
            onClicked: mouseClicked()
            onDoubleClicked: mouseDoubleClicked()

            propagateComposedEvents: true

            /* functions for mousearea */

            function mouseChangePosition(){

                if(moveApp.checkPressed){
                    var dx = mouseX - moveApp.startPositonX
                    var dy = mouseY - moveApp.startPositonY

                    appWindow.x += dx
                    appWindow.y += dy
                }
            }

            function mousePressed(){
                moveApp.startPositonX = mouseX
                moveApp.startPositonY = mouseY
                moveApp.checkPressed = true

                rectMain.border.width = 2
            }
            function mouseReleased(){
                moveApp.checkPressed = false
            }

            function mouseClicked(){
                textField.focus = true
            }

            function mouseDoubleClicked(){
                appWindow.height = rectMain.height
                listView.visible = false
                moveApp.checkDoubleClicked = true
                textField.clear()
                listView.closeListView()
            }

            Rectangle{

                id: btnApplicationHide

                width: parent.width / 5
                height: parent.height / 1.5

                color: "#007acc"
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter

                radius: height/8

                Label{
                    width: parent.width
                    height: parent.height
                    text: "HIDE"
                    color: "white"

                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter

                    font.family: "Arial"
                    font.pointSize: 10
                }

                MouseArea{
                    width: parent.width
                    height: parent.height
                    onClicked: hideApplication.running = true
                }
            }
        }
    }

    ListView{

        id: listView

        property real delegateHeight: 40
        property bool firstOpen: false

        width: parent.width
        height: contentHeight

        visible: false

        z: 0

        anchors.top: rectMain.bottom
        anchors.topMargin: 2

        spacing: 1

        delegate: ListViewComponent{}

        currentIndex: 0 //default currentIndex
        property real previousIndex: 0
        property real currentIndexEnter: 0

        onCurrentIndexChanged: currIndexChanged()

        // function current index changed

        function currIndexChanged(){
            if(listView.previousIndex!=0)
                listModel.setProperty(listView.previousIndex-1,"choosed",false)

            if(listView.currentIndex!=0)
                listModel.setProperty(listView.currentIndex-1,"choosed",true)

        }

        function closeListView(){
            if(listView.currentIndex != 0)
                listModel.setProperty(listView.currentIndex-1,"choosed",false)

            listView.currentIndex = 0
            listView.previousIndex = 0

        }

        function changeHeight(count_elements,max_size){
            if(count_elements === 0){
                listView.height = 0
                appWindow.height = rectMain.height
            }
            else if(count_elements < max_size){
                listView.height = (listView.delegateHeight + listView.spacing) * (count_elements)
                appWindow.height = rectMain.height + listView.height
            }

            else{
                listView.height = (40 + listView.spacing) * (max_size)
                appWindow.height = rectMain.height + listView.height
            }
        }

        ScrollBar.vertical: ScrollBar{
            id: scrollBar
            snapMode: "NoSnap"
            visible: true
            active: false
            width: 8
            interactive: false
            stepSize: 0.1
        }

        model: ListModel{
            id: listModel
        }

        Connections{
            target: googleApi
            onCreateListView : openListView(list)
            onOpenApplication: appWindow.visible = true


            function openListView(list){
                if(list.length === 0){
                    listView.closeListView()
                }
                else{
                    listModel.clear()
                    for(var i = 0; i < list.length; i++){
                        listModel.append({"text": list[i], "choosed":false})
                    }
                }
                listView.changeHeight(list.length,6)
            }
        }
    }
}
