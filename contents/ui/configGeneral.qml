import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: page

    property alias cfg_snippets: snippetsPlaceholder.text

    // This is a placeholder since snippets are managed in the main UI
    // but Plasma requires the property to be bound to a UI element to sync properly
    Label {
        id: snippetsPlaceholder
        visible: false
    }
}
