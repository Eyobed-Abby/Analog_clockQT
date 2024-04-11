import QtQuick

Item {
    id: root

    property int value: 0

    Rectangle{
        width: 1
        height: root.height * 0.6
        color: "red"

        anchors{
            horizontalCenter: root.horizontalCenter
        }

        antialiasing: true
        y: root.height * 0.05
    }

    rotation: 360/60 * (value % 60)
    antialiasing: true
}
