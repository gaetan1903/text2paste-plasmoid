// main.qml
import QtQuick
import org.kde.plasma.components
import org.kde.plasma.core
import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5 as Controls
import org.kde.kirigami as Kirigami
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.text2paste 1.0

PlasmoidItem {
    id: root
    title: qsTr("Simple Text to Paste")

    minimumWidth: Kirigami.Units.gridUnit * 20
    minimumHeight: Kirigami.Units.gridUnit * 20
    maximumWidth: minimumWidth  
    maximumHeight: minimumHeight
    width: minimumWidth
    height: minimumHeight

    pageStack.initialPage: initPage

    property var textList: []

    Component {
        id: initPage

        Kirigami.Page {
            title: qsTr("Texte to Paste")

            TextManager {
                id: textManager

                sourceText: root.textList
            }

            ColumnLayout {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }

                spacing: 5

                Controls.ScrollView {
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height * 0.87
                    contentItem: ListView {
                        id: listView
                        width: parent.width
                        height: parent.height
                        spacing: 10

                        model: textManager.sourceText
                        
                        delegate: RowLayout {
                            width: listView.width

                            // Afficher le texte
                            Controls.Label {
                                text: modelData
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }

                            // Bouton pour copier le texte
                            Controls.Button {
                                icon.name: "edit-copy"
                                onClicked: {
                                    textManager.copyToClipboard(modelData);
                                }
                            }

                            // Bouton pour supprimer le texte
                            Controls.Button {
                                icon.name: "edit-delete"
                                onClicked: {
                                    textManager.removeText(modelData);
                                }
                            }
                        }
                    }
                }
                // input pour ajouter un texte
                RowLayout {
                    Layout.fillWidth: true
                    Controls.TextField {
                        id: textInput
                        Layout.fillWidth: true
                        placeholderText: qsTr("Ajouter un texte")
                        onAccepted: {
                            textManager.sourceText = [textInput.text];
                            textInput.text = "";
                            listView.update();
                        }
                    }

                    Controls.Button {
                        icon.name: "list-add"
                        onClicked: {
                            // Ajouter le texte à la liste
                            // ici on ajoute le texte à la liste textManager.sourceText
                            // et non mettre a jour la liste textManager.sourceText
                            textManager.sourceText =  [textInput.text];
                            textInput.text = "";
                            listView.update();
                        }
                    }
                }
            }
        }
    }
  
}