pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls.Basic

import qs.config

ComboBox {
    id: control
    spacing: Config.spacing
    model: ["First", "Second", "Third"]

    delegate: ItemDelegate {
        id: delegate

        required property var model
        required property int index

        width: control.width
        contentItem: CText {
            text: delegate.model[control.textRole]
            font: control.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        highlighted: control.highlightedIndex === index

        background: null
    }

    contentItem: CText {
        leftPadding: control.spacing
        rightPadding: control.indicator.width + control.spacing

        text: control.displayText
        font: control.font
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 120
        implicitHeight: 40
        color: Colors.base
        border.color: Colors.overlay1
        border.width: control.visualFocus ? 2 : 1
        radius: Config.border.radius
    }

    popup: Popup {
        y: control.height - 1
        width: control.width
        height: Math.min(contentItem.implicitHeight, control.Window.height - topMargin - bottomMargin)
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator {}
        }

        background: Rectangle {
            color: Colors.base
            border.color: Colors.overlay1
            radius: Config.border.radius
        }
    }
}
