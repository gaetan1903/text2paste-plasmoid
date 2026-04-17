import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root

    property var sourceText: Plasmoid.configuration.snippets || []
    property var visibleSecrets: ({})

    // Ensure changes are synced back to configuration
    onSourceTextChanged: {
        Plasmoid.configuration.snippets = sourceText;
    }

    // Helper functions
    function getLabel(data) {
        if (typeof data !== 'string') return "";
        let index = data.indexOf(":");
        if (index !== -1) return data.substring(0, index);
        return data;
    }

    function getValue(data) {
        if (typeof data !== 'string') return "";
        let index = data.indexOf(":");
        if (index !== -1) return data.substring(index + 1);
        return data;
    }

    function addSnippet(label, value) {
        if (value === "") return;

        let entry = label !== "" ? (label + ":" + value) : value;
        if (sourceText.indexOf(entry) !== -1) return;

        let newList = [...sourceText];
        newList.push(entry);
        sourceText = newList;

        root.visibleSecrets = {};
    }

    function removeText(text) {
        let newList = [...sourceText];
        let index = newList.indexOf(text);
        if (index !== -1) {
            newList.splice(index, 1);
            sourceText = newList;
            root.visibleSecrets = {};
        }
    }

    function copyToClipboard(text) {
        tempCopyPasteField.text = text;
        tempCopyPasteField.selectAll();
        tempCopyPasteField.copy();
        tempCopyPasteField.text = "";
    }

    // This field is used as a workaround for clipboard access
    Controls.TextField {
        id: tempCopyPasteField
        visible: false
    }

    // Icon representation when in a panel
    compactRepresentation: MouseArea {
        anchors.fill: parent
        onClicked: root.expanded = !root.expanded

        Kirigami.Icon {
            anchors.fill: parent
            anchors.margins: Kirigami.Units.smallSpacing
            source: Plasmoid.icon || "edit-copy"
        }
    }

    // Full UI representation
    fullRepresentation: ColumnLayout {
        Layout.preferredWidth: Kirigami.Units.gridUnit * 25
        Layout.preferredHeight: Kirigami.Units.gridUnit * 20
        spacing: Kirigami.Units.smallSpacing

        Controls.ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ListView {
                id: listView
                model: root.sourceText
                spacing: Kirigami.Units.smallSpacing

                delegate: PlasmaComponents.ItemDelegate {
                    width: listView.width

                    contentItem: RowLayout {
                        id: delegateLayout
                        spacing: Kirigami.Units.smallSpacing

                        property string currentSnippet: modelData || ""
                        property bool isVisible: !!root.visibleSecrets[index]

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 0

                            PlasmaComponents.Label {
                                text: root.getLabel(delegateLayout.currentSnippet)
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                                font.bold: true
                            }

                            PlasmaComponents.Label {
                                text: delegateLayout.isVisible ? root.getValue(delegateLayout.currentSnippet) : "••••••••"
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                                font.family: "Monospace"
                                opacity: 0.6
                                font.pixelSize: Kirigami.Units.gridUnit * 0.6
                            }
                        }

                        // Toggle visibility
                        PlasmaComponents.ToolButton {
                            icon.name: delegateLayout.isVisible ? "visibility" : "hint"
                            onClicked: {
                                let newVisible = Object.assign({}, root.visibleSecrets);
                                newVisible[index] = !newVisible[index];
                                root.visibleSecrets = newVisible;
                            }
                        }

                        // Copy Button
                        PlasmaComponents.ToolButton {
                            id: copyButton
                            icon.name: "edit-copy"
                            onClicked: {
                                let val = root.getValue(delegateLayout.currentSnippet);
                                if (val !== "") {
                                    root.copyToClipboard(val);
                                    copyButton.icon.name = "emblem-success-symbolic";
                                    resetIconTimer.start();
                                }
                            }

                            Timer {
                                id: resetIconTimer
                                interval: 2000
                                onTriggered: copyButton.icon.name = "edit-copy"
                            }
                        }

                        // Delete Button
                        PlasmaComponents.ToolButton {
                            icon.name: "edit-delete"
                            onClicked: root.removeText(delegateLayout.currentSnippet)
                        }
                    }
                }
            }
        }

        Kirigami.Separator { Layout.fillWidth: true }

        GridLayout {
            columns: 3
            Layout.fillWidth: true

            PlasmaComponents.TextField {
                id: labelInput
                Layout.fillWidth: true
                placeholderText: qsTr("Label...")
            }

            PlasmaComponents.TextField {
                id: textInput
                Layout.fillWidth: true
                placeholderText: qsTr("Value...")
                onAccepted: {
                    root.addSnippet(labelInput.text.trim(), textInput.text.trim());
                    labelInput.text = "";
                    textInput.text = "";
                }
            }

            PlasmaComponents.Button {
                icon.name: "list-add"
                onClicked: {
                    root.addSnippet(labelInput.text.trim(), textInput.text.trim());
                    labelInput.text = "";
                    textInput.text = "";
                }
            }
        }
    }
}
