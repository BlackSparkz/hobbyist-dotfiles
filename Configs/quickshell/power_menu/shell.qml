import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

ShellRoot {
    PanelWindow {
        id: root

        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }

        color: "transparent"

        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.exclusiveZone: -1

        Process {
            id: runner
            onExited: Qt.quit()
        }

        function execute(cmd) {
            runner.command = ["sh", "-c", cmd]
            runner.running = true
        }

        Rectangle {
            anchors.fill: parent
            color: "#880d0f14"

            Item {
                anchors.fill: parent
                focus: true

                Keys.onPressed: event => {
                    switch (event.key) {
                        case Qt.Key_Escape: Qt.quit();                             break
                        case Qt.Key_L:      root.execute("bash ~/.config/Scripts/random_wall_on_lockscr.sh"); break
                        case Qt.Key_E:      root.execute("hyprctl dispatch exit"); break
                        case Qt.Key_S:      root.execute("systemctl suspend");     break
                        case Qt.Key_R:      root.execute("systemctl reboot");      break
                        case Qt.Key_P:      root.execute("systemctl poweroff");    break
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Qt.quit()
            }

            RowLayout {
                anchors.centerIn: parent
                spacing: 32

                Repeater {
                    model: [
                        { icon: "\uf023", label: "Lock",      key: "L", cmd: "bash ~/.config/Scripts/random_wall_on_lockscr.sh" },
                        { icon: "\uf08b", label: "Logout",    key: "E", cmd: "hyprctl dispatch exit" },
                        { icon: "\uf236", label: "Suspend",   key: "S", cmd: "systemctl suspend"     },
                        { icon: "\uf01e", label: "Reboot",    key: "R", cmd: "systemctl reboot"      },
                        { icon: "\uf011", label: "Shutdown",  key: "O", cmd: "systemctl poweroff"    },
                    ]

                    delegate: Rectangle {
                        required property var modelData

                        width:  200
                        height: 240
                        radius: 32

                        color:        area.containsMouse ? "#2affffff" : "#0fffffff"
                        border.color: area.containsMouse ? "#66ffffff" : "#22ffffff"
                        border.width: 1

                        MouseArea { anchors.fill: parent; onClicked: {} }

                        Behavior on color        { ColorAnimation { duration: 120 } }
                        Behavior on border.color { ColorAnimation { duration: 120 } }

                        scale: area.containsMouse ? 1.06 : 1.0
                        Behavior on scale { NumberAnimation { duration: 120; easing.type: Easing.OutCubic } }

                        MouseArea {
                            id: area
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: root.execute(modelData.cmd)
                        }

                        Column {
                            anchors.centerIn: parent
                            spacing: 14

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text:           modelData.icon
                                font.pixelSize: 80
                                font.family:    "Google Sans Flex"
                                color:          "white"
                                renderType:     Text.NativeRendering
                            }

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text:               modelData.label
                                font.pixelSize:     16
                                font.weight:        Font.Medium
                                font.letterSpacing: 0.5
                                color:              "#eeffffff"
                            }

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text:               "[" + modelData.key + "]"
                                font.pixelSize:     14
                                font.letterSpacing: 1
                                color:              "#66ffffff"
                            }
                        }
                    }
                }
            }
        }
    }
}
