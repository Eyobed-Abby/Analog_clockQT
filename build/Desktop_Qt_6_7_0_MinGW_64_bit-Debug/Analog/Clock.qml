import QtQuick

Item {
    id: root

    property color color: "white"
    property int hours: currentDate.getHours()
    property int minutes: currentDate.getMinutes()
    property int seconds: currentDate.getSeconds()
    property var currentDate: new Date()

    property var initialAmPm: currentDate.getHours() < 12 ? "AM" : "PM"

    Timer{
        id: timer
        repeat: true
        interval: 1000
        running: true

        onTriggered: root.currentDate = new Date()
    }

    Rectangle{
        property real _minSide: Math.min(root.width, root.height)
        id: wrapperCircle
        height: _minSide
        width: _minSide
        color: "black"
        border.color: "black"
        border.width: 2
        radius: width/2
        anchors.centerIn: parent



        Repeater{
            model: 60

            Item{
                id: outerContainer
                property int minute: index
                height: wrapperCircle.height/2
                transformOrigin: Item.Bottom
                rotation: index * 6
                x: wrapperCircle.width/2
                y: 0

                Text{
                    color: "white"
                    anchors{
                        horizontalCenter: parent.horizontalCenter
                    }
                    x: 0
                    y: wrapperCircle.height * 0.01
                    rotation: 360 - index * 6
                    visible: index % 5 == 0
                    text: outerContainer.minute == 0 ? "00" : outerContainer.minute
                    font.pixelSize: wrapperCircle.height * 0.03
                    // font.family: "Comic Sans MS"
                }

            }
        }
    }


    Rectangle{
        id: background
        anchors.centerIn: parent
        height: wrapperCircle.height*0.9
        width: height
        radius: width/2
        color: root.color
        border.color: "black"
        border.width: 4



        Repeater{
            model: 60

            Item{
                id: hourContainer
                property int hour: index
                height: background.height/2
                transformOrigin: Item.Bottom
                rotation: index * 6
                x: background.width/2
                y: 0

                Rectangle{
                    height: index % 5 == 0 ? background.height * 0.05 : background.height * 0.03
                    width: height*1/4
                    color: "black"
                    anchors{
                        horizontalCenter: parent.horizontalCenter
                        top: parent.top
                        topMargin: 4
                    }
                }

                Text{
                    anchors{
                        horizontalCenter: parent.horizontalCenter
                    }
                    x: 0
                    y: background.height * 0.06
                    rotation: 360 - index * 6
                    visible: index % 5 == 0
                    text: hourContainer.hour == 0 ? 12: hourContainer.hour/5
                    font.pixelSize: background.height * 0.1
                    font.family: "Comic Sans MS"
                }


            }
        }
    }

    Rectangle{
        id: center
        anchors.centerIn: parent
        height: background.height * 0.05
        width: height
        radius: width/2
        color: "black"


    }

    Second{
        anchors{
            top: background.top
            bottom: background.bottom
            horizontalCenter: parent.horizontalCenter
        }
        value: root.seconds

        onValueChanged: {
            if (value === 0) {
                root.minutes = (root.minutes + 1) % 60;
                minuteNeedle.value = root.minutes
                if (root.minutes === 0) {
                    root.hours = (root.hours + 1) % 12;
                }
            }
        }
    }

    Minute{
        id: minuteNeedle
        anchors{
            top: background.top
            bottom: background.bottom
            horizontalCenter: parent.horizontalCenter
        }

        value: root.minutes

        property int prevMinute: root.minutes
        onValueChanged: {
            if(value < 0){
                value += 60
            }

            var newValue = value % 60;
            //hour change case
            if (prevMinute == 0 & newValue == 59) {
                    root.hours = (root.hours - 1 + 12) % 12;
                if(root.hours == 11){
                    if(initialAmPm === "AM"){
                        initialAmPm = "PM"
                    }
                    else{
                        initialAmPm = "AM"
                    }
                }
            }
            else if(prevMinute == 59 & newValue == 0){
                root.hours = (root.hours + 1)%12
                if(root.hours == 0){
                    if(initialAmPm === "AM"){
                        initialAmPm = "PM"
                    }
                    else{
                        initialAmPm = "AM"
                    }
                }
            }
            root.minutes = newValue;
            prevMinute = newValue;
          }
    }

    Hour{
        id: hourNeedle
        anchors{
            top: background.top
            bottom: background.bottom
            horizontalCenter: parent.horizontalCenter
        }
        value: root.hours
        valueminute: root.minutes

        property int prevHour: root.hours
        onValueChanged: {
            root.hours = parseInt(value%12)
            var hourDiff= value - prevHour
            var minuteDiff = hourDiff * 60

            if (hourDiff < 0) {
                root.minutes = (valueminute + minuteDiff) % 60
                if (root.minutes < 0) {
                    root.minutes += 60
                }

            } else {
                root.minutes = (valueminute + minuteDiff) % 60
            }

            minuteNeedle.value = root.minutes



        }
    }
    Rectangle{
        id: centerTextContainer
        width: background.width*0.3
        height: background.height*0.09
        color: "transparent"
        opacity: 0.5
        anchors{
            horizontalCenter: root.horizontalCenter
            bottom: center.top
            bottomMargin: 10
        }

        Text{
            id: centerText
            anchors.centerIn: parent
            property var cur: root.hours == 0 ? 12 : Math.abs(root.hours)
            property var curMin: hourNeedle.valueminute < 10 ? "0" + hourNeedle.valueminute : root.minutes

            text: cur + ":" + curMin + " " + initialAmPm
            font.pixelSize: Math.floor(background.height*0.06)
            color: "black"
            font.bold: true
            z: 1
        }
        z: 1
    }





    Binding{
        target: hourNeedle
        property: "value"
        value:root.hours
    }


    // Binding{
    //     target: minuteNeedle
    //     property: "value"
    //     value: root.minutes
    // }











}
