import QtQuick

Item {
    id: root

    property real value: 0
    property real valueminute: 0
    // property real difference: 0


    Rectangle{
        width: root.height * 0.025
        height: root.height * 0.3
        color: "black"

        anchors{
            horizontalCenter: root.horizontalCenter
            bottom: root.verticalCenter
        }

        antialiasing: true

        Rectangle{
            id: circle
            width: parent.height*.4
            height: width
            radius: width/2
            color: "transparent"
            border.color: "grey"
            border.width: 1
            opacity: 0.5


            anchors{
                centerIn: parent
                verticalCenterOffset: -0.99 * height
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

                    var changeInValue = angle* 12/360
                    var changeInValueMinute = (angle*12)/6
                    var newMinuteValue = (valueminute + changeInValueMinute)%60
                    var newHourValue = value + changeInValue
                    newHourValue = newHourValue >= 0 ? newHourValue % 12 : 12 + (newHourValue % 12)
                    root.value = newHourValue;



                }
            }
        }
    }

    rotation: 360/12 * (value % 12) + 360/12 * (valueminute / 60)
    antialiasing: true


}
