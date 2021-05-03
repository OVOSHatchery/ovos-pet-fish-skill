import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import org.kde.lottie 1.0
import Mycroft 1.0 as Mycroft

Mycroft.Delegate {
    id: root
    leftPadding: 0
    rightPadding: 0
    topPadding: 0
    bottomPadding: 0
    property bool itemInAction: false
    property bool inSleep: false
    property int screenXEnd: root.width
    property int screenYEnd: root.height
    property int screenCenterX: (mainItem.width - lottietest.width) / 2
    property int screenCenterY: (mainItem.height - lottietest.height) / 2
    property var petAction: sessionData.pet_action
    
    onPetActionChanged: {
        if(petAction == "swim"){
            swimAround()
        } else if(petAction == "playdead") {
            playdead()
        } else if(petAction == "eatfood") {
            eatfood()
        } else if(petAction == "introduce") {
            introAnim()
        } else if(petAction == "dance") {
            dance()
        } else if(petAction == "sleep") {
            sleep()
        } else if(petAction == "awake") {
            awaken()
        } else if(petAction == "eatfish") {
            eatAnotherFish()
        }
    }

    Timer {
        id: timer
    }

    function delay(delayTime, cb) {
        timer.interval = delayTime;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.triggered.connect(function release () {
            timer.triggered.disconnect(cb); // This is important
            timer.triggered.disconnect(release); // This is important as well
        });
        timer.start();
    }

    function swimAround(){
        if(!itemInAction && !inSleep){
            swimAroundAnim.start()
            itemInAction = true
            chatBox.visible = true
            chat.text = "Zippyyy!"
            delay(3000, function() {
                chatBox.visible = false
            })
        }
    }

    function playDead(){
        if(!itemInAction && !inSleep){
            playDeadAnim.start()
            itemInAction = true
            chatBox.visible = true
            chat.text = "Oh Noes! *_*"
            delay(3000, function() {
                chatBox.visible = false
            })
        }
    }

    function eatFood(){
        if(!itemInAction && !inSleep){
            eatFoodAnim.start()
            itemInAction = true
            feeds1.visible = true
            feeds2.visible = true
            chatBox.visible = true
            chat.text = "Nom Nom!"
            delay(3000, function() {
                chatBox.visible = false
                feeds1.visible = false
                delay(500, function(){
                    feeds2.visible = false
                })
            })
        }
    }

    function introAnim(){
        if(!itemInAction && !inSleep){
            introductionAnim.start()
            itemInAction = true
            chatBox.visible = true
            chat.text = "Howdy! \n I am Dory your new pet fish :)"
            delay(3000, function() {
                chatBox.visible = false
            })
        }
    }

    function dance(){
        if(!itemInAction && !inSleep){
            console.log("here in dance start")
            danceAnim.start()
            itemInAction = true
        }
    }

    function sleep(){
        if(!itemInAction){
            sleepAnim.start()
            inSleep = true
        }
    }

    function awaken(){
        if(inSleep) {
            sleepAnim.stop()
            awakeAnim.start()
            slpbtn.text = "Sleep"
            inSleep = false
        }
    }

    function eatAnotherFish(){
        if(!itemInAction){
            createFishFood()
        }
    }

    function createFishFood(){
        var component = Qt.createComponent("FoodFeed.qml");
        if (component.status != Component.Ready)
        {
            if (component.status == Component.Error) {
                console.debug("Error: "+ component.errorString());
            }
            return;
        } else {
            var feed = component.createObject(foodSources, {"width": foodSources.width, "height": foodSources.height, "x": -300, "y": screenCenterY})
            eatFishAnim.start()
            itemInAction = true
            feed.destroy(1500)
        }
    }

    Image {
        id: mainItem
        anchors.fill: parent
        source: Qt.resolvedUrl("assets/ocean.png")
        transformOrigin: Item.Center

        Row {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 16
            anchors.rightMargin: 16
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 16
            anchors.horizontalCenter: parent.horizontalCenter
            height: 40

            Button {
                width: parent.width / 9
                height: 40
                background: Rectangle {
                    radius: 30
                    color: Qt.rgba(0, 0, 0, 0.75)
                }
                contentItem: Text {
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: height * 0.4
                    color: "white"
                    text: "<"
                }
                onClicked: {
                    triggerGuiEvent("pet.fish.close.screen", {})
                }
            }
            
            Button {
                width: parent.width / 9
                height: 40
                background: Rectangle {
                    radius: 30
                    color: Qt.rgba(0, 0, 0, 0.75)
                }
                contentItem: Text {
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: height * 0.4
                    color: "white"
                    text: "Swim"
                }
                onClicked: {
                    swimAround()
                }
            }
            
            Button {
                width: parent.width / 9
                height: 40
                background: Rectangle {
                    radius: 30
                    color: Qt.rgba(0, 0, 0, 0.75)
                }
                contentItem: Text {
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: height * 0.4
                    color: "white"
                    text: "Play Dead"
                }
                onClicked: {
                    playDead()
                }
            }

            Button {
                width: parent.width / 9
                height: 40
                background: Rectangle {
                    radius: 30
                    color: Qt.rgba(0, 0, 0, 0.75)
                }
                contentItem: Text {
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: height * 0.4
                    color: "white"
                    text: "Eat Food"
                }
                onClicked: {
                    eatFood()
                }
            }
            
            Button {
                width: parent.width / 9
                height: 40
                background: Rectangle {
                    radius: 30
                    color: Qt.rgba(0, 0, 0, 0.75)
                }
                contentItem: Text {
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: height * 0.4
                    color: "white"
                    text: "Say Hi!"
                }
                onClicked: {
                    introAnim()
                }
            }
            
            Button {
                width: parent.width / 9
                height: 40
                background: Rectangle {
                    radius: 30
                    color: Qt.rgba(0, 0, 0, 0.75)
                }
                contentItem: Text {
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: height * 0.4
                    color: "white"
                    text: "Dance"
                }
                onClicked: {
                    dance()
                }
            }
            
            Button {
                width: parent.width / 9
                height: 40
                background: Rectangle {
                    radius: 30
                    color: Qt.rgba(0, 0, 0, 0.75)
                }
                contentItem: Text {
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: height * 0.4
                    color: "white"
                    text: "Eat Fish"
                }
                onClicked: {
                    eatAnotherFish()
                }
            }
            
            Button {
                id: slpbtn
                width: parent.width / 9
                height: 40
                background: Rectangle {
                    radius: 30
                    color: Qt.rgba(0, 0, 0, 0.75)
                }
                contentItem: Text {
                    id: innertxt
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: height * 0.4
                    color: "white"
                    text: "Sleep"
                }
                onClicked: {
                    if(!inSleep){
                        sleep()
                    } else {
                        awaken()
                    }
                }
            }
        }

        Rectangle {
            id: chatBox
            width: lottietest.width * 0.75
            height: chat.contentHeight + 16
            anchors.bottom: lottietest.verticalCenter
            anchors.bottomMargin: 80
            anchors.horizontalCenter: lottietest.horizontalCenter
            visible: false
            color: Qt.rgba(255, 255, 255, 0.6)
            radius: 20

            Label {
                id: chat
                width: parent.width
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 18
                wrapMode: Text.WordWrap
            }
        }

        Image {
            id: feeds1
            width: 25
            height: 25
            x: screenCenterX + 200
            y: screenCenterY + 40
            visible: false
            source: Qt.resolvedUrl("assets/feed-1.png")
        }

        Image {
            id: feeds2
            width: 25
            height: 25
            x: screenCenterX + 100
            y: screenCenterY + 40
            visible: false
            source: Qt.resolvedUrl("assets/feed-2.png")
        }

        Item {
            id: foodSources
            width: 400
            height: 400
        }

        LottieAnimation {
            id: lottietest
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            source: Qt.resolvedUrl("assets/fish-comp.json")
            //loops: LottieAnimation.Infinite
            //autoPlay: true
            scale: 0.5
        }

        PropertyAnimation {
            id: swimAroundAnim
            target: lottietest
            property: "x"
            loops: 3
            from: screenXEnd
            to: 0 + -500
            duration: 3000

            onFinished: {
                lottietest.x = screenCenterX
                lottietest.y = screenCenterY
                itemInAction = false
            }
        }

        PathAnimation {
            id: playDeadAnim
            duration: 6000
            easing.type: Easing.InQuad
            target: lottietest
            orientation: PathAnimation.RightFirst
            path: Path {
                startX: screenCenterX; startY: screenCenterY

                PathCubic {
                    x: 0 - 50
                    y: 0 - 50

                    control1X: x; control1Y: 50
                    control2X: 50; control2Y: 50
                }
            }
            onFinished: {
                lottietest.x = screenCenterX
                lottietest.y = screenCenterY
                lottietest.rotation = 0
                itemInAction = false
            }
        }

        PathAnimation {
            id: eatFoodAnim
            duration: 6000
            easing.type: Easing.InQuad
            target: lottietest
            path: Path {
                startX: screenXEnd + 100; startY: screenCenterY

                PathCubic {
                    x: -100
                    y: 0

                    control1X: -100; control1Y: screenCenterY - 140
                }
            }
            onFinished: {
                lottietest.x = screenCenterX
                lottietest.y = screenCenterY
                lottietest.rotation = 0
                itemInAction = false
            }
        }

        PathAnimation {
            id: introductionAnim
            duration: 3000
            easing.type: Easing.InQuad
            target: lottietest
            path: Path {
                startY: lottietest.y
                PathCurve{x: lottietest.x; y: lottietest.y + 25}
                PathCurve{x: lottietest.x; y: lottietest.y - 25}
                PathCurve{x: lottietest.x; y: lottietest.y + 25}
                PathCurve{x: lottietest.x; y: lottietest.y - 25}
                PathCurve{x: lottietest.x; y: lottietest.y + 25}
                PathCurve{x: lottietest.x; y: lottietest.y - 25}
                PathCurve{x: lottietest.x; y: lottietest.y + 25}
                PathCurve{x: lottietest.x; y: lottietest.y - 25}
                PathCurve{x: lottietest.x; y: lottietest.y}
            }
            onFinished: {
                lottietest.x = screenCenterX
                lottietest.y = screenCenterY
                lottietest.rotation = 0
                itemInAction = false
            }
        }

        SequentialAnimation {
            id: sleepAnim
            NumberAnimation { target: lottietest; property: "y"; to: screenCenterY + 110; duration: 800}

            SequentialAnimation {
                loops: Animation.Infinite
                ParallelAnimation {
                    NumberAnimation { target: lottietest; property: "opacity"; to: 0.7; duration: 200}
                    PropertyAnimation { target: chatBox; property: "visible"; to: true; duration: 100}
                    PropertyAnimation { target: chat; property: "text"; to: "Zzz!"; duration: 1200}
                }
                PropertyAnimation { target: chat; property: "text"; to: "Zzz! Zzz!"; duration: 1600}
                PropertyAnimation { target: chat; property: "text"; to: "Zzz! Zzz! Humans.."; duration: 1600}
                PropertyAnimation { target: chat; property: "text"; to: "Zzz! Zzz! Feed.."; duration: 1600}
                PropertyAnimation { target: chat; property: "text"; to: "Zzz! Zzz! Dory.."; duration: 1600}
                PropertyAnimation { target: chat; property: "text"; to: "Zzz! Zzz! Dory.. Dream.. Icecream"; duration: 1600}
                PropertyAnimation { target: chat; property: "text"; to: "Zzz! Zzz! Dory.. Eat.. Zzz!"; duration: 1600}
                PropertyAnimation { target: chat; property: "text"; to: "Zzz! Zzz! Dory.. Sleep!"; duration: 1600}
                PropertyAnimation { target: chat; property: "text"; to: "Zzz! Zzz! Dory.. Sleep!"; duration: 1600}
            }

            onStarted: {
                slpbtn.contentItem.text = "Awaken"
            }
        }

        ParallelAnimation {
            id: awakeAnim
            NumberAnimation { target: lottietest; property: "y"; to: screenCenterY; duration: 800}
            NumberAnimation { target: lottietest; property: "opacity"; to: 1; duration: 200}
            PropertyAnimation { target: chatBox; property: "visible"; to: false; duration: 100}

            onFinished: {
                itemInAction = false
                slpbtn.contentItem.text = "Sleep"
            }
        }

        ParallelAnimation {
            id: eatFishAnim

            PropertyAnimation {
                target: lottietest
                property: "x"
                loops: 1
                from: screenXEnd
                to: 0 + -500
                duration: 3000
            }

            PropertyAnimation {
                target: foodSources
                property: "x"
                loops: 1
                from: -100
                to: screenXEnd
                duration: 3000
            }

            onFinished: {
                lottietest.x = screenCenterX
                lottietest.y = screenCenterY
                itemInAction = false
            }
        }

        SequentialAnimation {
            id: danceAnim
            loops: 2

            NumberAnimation { target: lottietest; property: "x"; to: screenCenterX - 100; duration: 200}
            NumberAnimation { target: lottietest; property: "opacity"; to: 0.0; duration: 200}
            NumberAnimation { target: lottietest; property: "opacity"; to: 1.0; duration: 200}
            RotationAnimation {
                target: lottietest
                from: 0;
                to: 360;
                duration: 1000
            }
            NumberAnimation { target: lottietest; property: "x"; to: screenCenterX + 200; duration: 200}
            NumberAnimation { target: lottietest; property: "opacity"; to: 0.0; duration: 200}
            NumberAnimation { target: lottietest; property: "opacity"; to: 1.0; duration: 200}
            RotationAnimation {
                target: lottietest
                from: 360;
                to: 0;
                duration: 1000
            }
            NumberAnimation { target: lottietest; property: "x"; to: screenCenterX; duration: 200}
            NumberAnimation { target: lottietest; property: "y"; to: 50; duration: 200}
            NumberAnimation { target: lottietest; property: "opacity"; to: 0.0; duration: 200}
            NumberAnimation { target: lottietest; property: "opacity"; to: 1.0; duration: 200}
            RotationAnimation {
                target: lottietest
                from: 0;
                to: 360;
                duration: 1000
            }
            NumberAnimation { target: lottietest; property: "x"; to: screenCenterX; duration: 200}
            NumberAnimation { target: lottietest; property: "y"; to: -50; duration: 200}
            NumberAnimation { target: lottietest; property: "opacity"; to: 0.0; duration: 200}
            NumberAnimation { target: lottietest; property: "opacity"; to: 1.0; duration: 200}
            RotationAnimation {
                target: lottietest
                from: 360;
                to: 0;
                duration: 1000
            }
            NumberAnimation { target: lottietest; property: "x"; to: screenCenterX; duration: 200}
            NumberAnimation { target: lottietest; property: "y"; to: 0; duration: 200}
            NumberAnimation { target: lottietest; property: "opacity"; to: 0.0; duration: 200}
            ParallelAnimation {
                NumberAnimation { target: lottietest; property: "opacity"; to: 1.0; duration: 200}
                PropertyAnimation { target: chatBox; property: "visible"; to: true; duration: 100}
                PropertyAnimation { target: chat; property: "text"; to: "Check Me Out!"; duration: 100}
            }


            RotationAnimation {
                target: lottietest
                from: 360;
                to: 0;
                duration: 1000
            }
            NumberAnimation { target: lottietest; property: "opacity"; to: 0.0; duration: 500}
            NumberAnimation { target: lottietest; property: "opacity"; to: 1.0; duration: 500}
            RotationAnimation {
                target: lottietest
                from: 0;
                to: 360;
                duration: 1000
            }
            NumberAnimation { target: lottietest; property: "opacity"; to: 0.0; duration: 500}
            NumberAnimation { target: lottietest; property: "opacity"; to: 1.0; duration: 500}
            PropertyAnimation { target: chatBox; property: "visible"; to: false; duration: 100}

            onFinished: {
                lottietest.x = screenCenterX
                lottietest.y = screenCenterY
                lottietest.rotation = 0
                itemInAction = false
            }
        }
    }
}
