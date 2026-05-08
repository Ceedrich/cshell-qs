import QtQuick.Controls
import QtQuick.Layouts
import QtQuick

import qs.config
import qs.widgets

ColumnLayout {
    id: root
    spacing: 0

    PlainText {
        horizontalAlignment: Text.AlignHCenter
        Layout.fillWidth: true
        text: grid.title
        font.bold: true
    }

    DayOfWeekRow {
        locale: grid.locale

        Layout.fillWidth: true

        delegate: PlainText {
            required property string shortName

            font.bold: true
            text: shortName
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    MonthGrid {
        id: grid
        delegate: PlainText {
            required property var model

            color: model.month === grid.month ? model.today ? Colors.accent : defaultColor : Colors.overlay1

            text: model.day
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Layout.fillWidth: true
    }
}
