import QtQuick

Window {
    id: window
    width:400
    height: 400
    visible: true
    title: qsTr("Analog Clock")

    Clock{
        id: clock
        width: window.width
        height: window.height
    }
}
