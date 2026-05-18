import QtQuick

import qs.config

Rectangle {
    enum Orientation {
        Horizontal,
        Vertical
    }

    required property int orientation

    width: (orientation === CDivider.Orientation.Vertical) ? 4 : parent.width
    height: (orientation === CDivider.Orientation.Vertical) ? parent.height : 4

    color: Colors.overlay1
}
