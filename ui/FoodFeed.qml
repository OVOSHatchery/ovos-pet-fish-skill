import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import org.kde.lottie 1.0

Item {
    visible: true

    LottieAnimation {
        source: Qt.resolvedUrl("assets/fishyfeed.json")
        anchors.fill: parent
        scale: 0.5
        rotation: 45
    }
}
