pragma ComponentBehavior: Bound

import QtQuick.Controls
import QtQuick.Layouts
import QtQuick

import qs.config
import qs.widgets

ColumnLayout {
    id: root
    spacing: 0

    RowLayout {
        CButton {
            text: "󰁍"
            onClicked: grid.prevMonth()
        }

        CText {
            Layout.fillWidth: true
        }

        CButton {
            horizontalAlignment: Text.AlignHCenter
            text: grid.title
            font.bold: true

            onClicked: grid.selectToday()
        }

        CText {
            Layout.fillWidth: true
        }

        CButton {
            text: "󰁔"
            onClicked: grid.nextMonth()
        }
    }

    DayOfWeekRow {
        locale: grid.locale

        Layout.fillWidth: true

        delegate: CText {
            required property string shortName

            font.bold: true
            text: shortName
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    MonthGrid {
        id: grid
        spacing: Config.spacing
        property date selectedDate: new Date()

        delegate: CButton {
            required property var model

            property bool isSelected: (model.day === grid.selectedDate.getDate() && model.month === grid.selectedDate.getMonth() && model.year === grid.selectedDate.getFullYear())

            mouseareaEnabled: model.month === grid.month

            textColor: {
                if (model.month === grid.month) {
                    if (isSelected) {
                        return Colors.base;
                    }
                    if (model.today) {
                        return Colors.accent;
                    }
                    return defaultColor;
                }
                return Colors.overlay1;
            }
            backgroundColor: isSelected ? Colors.accent : "transparent"
            font.bold: isSelected || model.today

            onClicked: {
                if (model.date.getMonth() === grid.month) {
                    grid.selectedDate = model.date;
                }
            }

            text: model.day
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Layout.fillWidth: true

        function prevMonth() {
            if (month == Calendar.January) {
                month = Calendar.December;
                year -= 1;
            } else {
                month -= 1;
            }
        }

        function nextMonth() {
            if (month == Calendar.December) {
                month = Calendar.January;
                year += 1;
            } else {
                month += 1;
            }
        }

        function selectToday() {
            selectedDate = new Date();
            month = selectedDate.getMonth();
            year = selectedDate.getFullYear();
        }
    }
}
