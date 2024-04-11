import QtQuick

Item {
    id: root

    property int value: 0



    Rectangle{
        width: root.height * 0.025
        height: root.height * 0.4
        color: "black"

        anchors{
            horizontalCenter: root.horizontalCenter
            bottom: root.verticalCenter
        }

        antialiasing: true
        Rectangle{
            id: circle
            width: parent.height*.3
            height: width
            radius: width/2
            color: "transparent"
            border.color: "grey"
            border.width: 1
            opacity: 0.5


            anchors{
                centerIn: parent
                verticalCenterOffset: -1.5 * height
            }

            z: 1



            MouseArea {
                id: dragArea
                anchors.fill: parent
                drag.target: circle
                drag.axis: Drag.XAndYAxis
                // drag.threshold: 10


                onPositionChanged: {
                    var dx = dragArea.mouseX - circle.width/2
                    var dy = dragArea.mouseY - circle.height/2
                    var angle = Math.atan2(dy, dx) * 180 / Math.PI
                    root.value += Math.round(angle * 60 / 360) % 60

                }
            }
        }
    }

    rotation: 360/60 * (value % 60)
    antialiasing: true
}