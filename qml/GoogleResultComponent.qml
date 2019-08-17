import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0

Component{

    id: listViewDelegate
    Rectangle{
        id: rectApiGoogle
        width: parent.width
        height: listView.delegateHeight
        color: "transparent"
        opacity: 0.6
        NumberAnimation {

            id: animationGoogleApp
            running: listView.firstOpen
            target: rectApiGoogle
            property: "y"
            from: rectMain.y
            to: (rectApiGoogle.height + listView.spacing) * index
            duration: 250
            easing.type: Easing.InOutQuad
        }
        ParallelAnimation {

            id: chooseRectApiGoogle
            running: model.choosed
            NumberAnimation {
                target: rectApiGoogle
                property: "opacity"
                to: 1
                duration: 400
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: gradientStop
                property: "position"
                to: 0.4
                duration: 400
                easing.type: Easing.InOutQuad
            }
        }
        ParallelAnimation {
            id: unchooseRectApiGoogle
            running: !model.choosed
            NumberAnimation {
                target: rectApiGoogle

                property: "opacity"
                to: 0.6
                duration: 400
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: gradientStop
                property: "position"
                to: 0.0
                duration: 400
                easing.type: Easing.InOutQuad
            }
        }

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, parent.height/2)
            end: Qt.point(parent.width, parent.height)
            gradient: Gradient {
                GradientStop {id: gradientStop; position: 0.0; color: "#009900" }
                GradientStop { position: 1; color: "transparent" }
            }
        }
        Label{

            width: parent.width
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: 10

            text: model.text
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft

            font.family: "Arial"
            font.pointSize: 12

            color: "white"
        }

        MouseArea{
            width: parent.width
            height: parent.height
            onClicked: clickOnDelegate()
            onDoubleClicked: doubleClickedDelegate()

            function clickOnDelegate(){
                listView.previousIndex = listView.currentIndex
                listView.currentIndex = index + 1
                listView.currentIndexEnter = listView.currentIndex
            }

            function doubleClickedDelegate(){
                rectMain.onEnter()
                textField.editFinished()
            }
        }
    }
}
