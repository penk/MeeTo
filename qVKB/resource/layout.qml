//import QtQuick 1.0
import Qt 4.7

Item {
    id: keyboard
    width: 1024
    height: 352
    objectName: "keyboard"
    PropertyAnimation { id: hide; target: keyboard; properties: "height"; to: "0"; duration: 50; easing.type: Easing.InOutQuad; }
    PropertyAnimation { id: show; target: keyboard; properties: "height"; to: "352"; duration: 50; easing.type: Easing.InOutQuad; }

    function toggle() {
        if (keyboard.height == 0) show.start();
        else hide.start();
    }
    function focusin() { show.start(); }
    function focusout() { hide.start(); }

    Rectangle {
        id: layout_default

        Image {
            source: ":image/keyboard-default.png"

            Button {
                x: 6; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("q")
            }
            Button {
                x: 99; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("w")
            }
            Button {
                x: 192; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("e")
            }
            Button {
                x: 285; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("r")
            }
            Button {
                x: 378; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("t")
            }
            Button {
                x: 471; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("y")
            }
            Button {
                x: 564; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("u")
            }
            Button {
                x: 657; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("i")
            }
            Button {
                x: 750; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("o")
            }
            Button {
                x: 843; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("p")
            }
            Button {
                x: 937; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey(":backspace")
            }

    // second raw
            Button {
                x: 44; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("a")
            }

            Button {
                x: 136; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("s")
            }

            Button {
                x: 228; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("d")
            }

            Button {
                x: 320; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("f")
            }

            Button {
                x: 412; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("g")
            }
            Button {
                x: 504; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("h")
            }
            Button {
                x: 596; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("j")
            }
            Button {
                x: 688; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("k")
            }
            Button {
                x: 780; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("l")
            }
            Button {
                type: "return"
                x: 872; y: 96; height: 75; width: 146
                onClicked: Keyboard.sendKey(":enter")
            }

// third raw
            Button {
                x: 6; y: 182; height: 75; width: 146
                onClicked: { layout_capslock.visible = true; layout_default.visible = false; } 
            }
            Button {
                x: 98; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("z")
            }
            Button {
                x: 188; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("x")
            }
            Button {
                x: 278; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("c")
            }
            Button {
                x: 368; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("v")
            }
            Button {
                x: 459; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("b")
            }
            Button {
                x: 550; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("n")
            }
            Button {
                x: 640; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("m")
            }
            Button {
                x: 731; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey(",")
            }
            Button {
                x: 821; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey(".")
            }
            Button {
                type: "rightshift"
                x: 911; y: 182; height: 75; width: 107
                onClicked: { layout_capslock.visible = true; layout_default.visible = false; } 
            }

// forth raw

            Button {
                type: "leftpun"
                x: 6; y: 268; height: 75; width: 124
                onClicked: { layout_numeric.visible = true; layout_default.visible = false; } 
            }

            Button {
                type: "leftpun"
                x: 142; y: 268; height: 75; width: 124
                onClicked: { layout_default.visible = true; layout_default.visible = false; } 
            }

            Button {
                type: "space"
                x: 278; y: 268; height: 75; width: 441
                onClicked: Keyboard.sendKey(" ")
            }

            Button {
                type: "rightpun"
                x: 731; y: 268; height: 75; width: 196
                onClicked: { layout_numeric.visible = true; layout_default.visible = false; } 
            }

            Button {
                x: 939; y: 268; height: 75; width: 196
                onClicked: Keyboard.sendKey(":hide") // hide.start(); // 
            }

        }
    }


    Rectangle {
        id: layout_capslock
        visible: false

        Image {
            source: ":image/keyboard-capslock.png"

            Button {
                x: 6; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("Q")
            }
            Button {
                x: 99; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("W")
            }
            Button {
                x: 192; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("E")
            }
            Button {
                x: 285; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("R")
            }
            Button {
                x: 378; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("T")
            }
            Button {
                x: 471; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("Y")
            }
            Button {
                x: 564; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("U")
            }
            Button {
                x: 657; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("I")
            }
            Button {
                x: 750; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("O")
            }
            Button {
                x: 843; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("P")
            }
            Button {
                x: 937; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey(":backspace")
            }

    // second raw
            Button {
                x: 44; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("A")
            }

            Button {
                x: 136; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("S")
            }

            Button {
                x: 228; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("D")
            }

            Button {
                x: 320; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("F")
            }

            Button {
                x: 412; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("G")
            }
            Button {
                x: 504; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("H")
            }
            Button {
                x: 596; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("J")
            }
            Button {
                x: 688; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("K")
            }
            Button {
                x: 780; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("L")
            }
            Button {
                type: "return"
                x: 872; y: 96; height: 75; width: 146
                onClicked: Keyboard.sendKey(":enter")
            }

// third raw
            Button {
                x: 6; y: 182; height: 75; width: 146
                onClicked: { layout_default.visible = true; layout_capslock.visible = false; } 
            }
            Button {
                x: 98; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("Z")
            }
            Button {
                x: 188; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("X")
            }
            Button {
                x: 278; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("C")
            }
            Button {
                x: 368; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("V")
            }
            Button {
                x: 459; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("B")
            }
            Button {
                x: 550; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("N")
            }
            Button {
                x: 640; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("M")
            }
            Button {
                x: 731; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("!")
            }
            Button {
                x: 821; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("?")
            }
            Button {
                type: "rightshift"
                x: 911; y: 182; height: 75; width: 107
                onClicked: { layout_default.visible = true; layout_capslock.visible = false; } 
            }

// forth raw

            Button {
                type: "leftpun"
                x: 6; y: 268; height: 75; width: 124
                onClicked: { layout_numeric.visible = true; layout_capslock.visible = false; } 
            }

            Button {
                type: "leftpun"
                x: 142; y: 268; height: 75; width: 124
                onClicked: { layout_default.visible = true; layout_capslock.visible = false; } 
            }

            Button {
                type: "space"
                x: 278; y: 268; height: 75; width: 441
                onClicked: Keyboard.sendKey(" ")
            }

            Button {
                type: "rightpun"
                x: 731; y: 268; height: 75; width: 196
                onClicked: { layout_numeric.visible = true; layout_capslock.visible = false; } 
            }

            Button {
                x: 939; y: 268; height: 75; width: 196
                onClicked: hide.start(); // Keyboard.sendKey(":hide")
            }

        }
    }


    Rectangle {
        id: layout_numeric
        visible: false

        Image {
            source: ":image/keyboard-numeric.png"

            Button {
                x: 6; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("1")
            }
            Button {
                x: 99; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("2")
            }
            Button {
                x: 192; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("3")
            }
            Button {
                x: 285; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("4")
            }
            Button {
                x: 378; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("5")
            }
            Button {
                x: 471; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("6")
            }
            Button {
                x: 564; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("7")
            }
            Button {
                x: 657; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("8")
            }
            Button {
                x: 750; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("9")
            }
            Button {
                x: 843; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("0")
            }
            Button {
                x: 937; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey(":backspace")
            }

    // second raw
            Button {
                x: 44; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("-")
            }

            Button {
                x: 136; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("/")
            }

            Button {
                x: 228; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey(":")
            }

            Button {
                x: 320; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey(";")
            }

            Button {
                x: 412; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("(")
            }
            Button {
                x: 504; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey(")")
            }
            Button {
                x: 596; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("$")
            }
            Button {
                x: 688; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("&")
            }
            Button {
                x: 780; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("@")
            }
            Button {
                type: "return"
                x: 872; y: 96; height: 75; width: 146
                onClicked: Keyboard.sendKey(":enter")
            }

// third raw
            Button {
                x: 6; y: 182; height: 75; width: 80
                onClicked: { layout_punctuation.visible = true; layout_numeric.visible = false; } 
            }
            Button {
                type: "undo"
                x: 98; y: 182; height: 75; width: 170
                onClicked: Keyboard.sendKey(":undo")
            }
            Button {
                x: 278; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey(".")
            }
            Button {
                x: 368; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey(",")
            }
            Button {
                x: 459; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("?")
            }
            Button {
                x: 550; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("!")
            }
            Button {
                x: 640; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("'")
            }
            Button {
                x: 731; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey('"')
            }

            Button {
                type: "rightshift"
                x: 911; y: 182; height: 75; width: 107
                onClicked: { layout_punctuation.visible = true; layout_numeric.visible = false; } 
            }

// forth raw

            Button {
                type: "leftpun"
                x: 6; y: 268; height: 75; width: 124
                onClicked: { layout_default.visible = true; layout_numeric.visible = false; } 
            }

            Button {
                type: "leftpun"
                x: 142; y: 268; height: 75; width: 124
                onClicked: { layout_default.visible = true; layout_numeric.visible = false; } 
            }

            Button {
                type: "space"
                x: 278; y: 268; height: 75; width: 441
                onClicked: Keyboard.sendKey(" ")
            }

            Button {
                type: "rightpun"
                x: 731; y: 268; height: 75; width: 196
                onClicked: { layout_default.visible = true; layout_numeric.visible = false; } 
            }

            Button {
                x: 939; y: 268; height: 75; width: 196
                onClicked: hide.start(); // Keyboard.sendKey(":hide")
            }
        }
    }

    Rectangle {
        id: layout_punctuation
        visible: false

        Image {
            source: ":image/keyboard-punctuation.png"

            Button {
                x: 6; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("[")
            }
            Button {
                x: 99; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("]")
            }
            Button {
                x: 192; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("{")
            }
            Button {
                x: 285; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("}")
            }
            Button {
                x: 378; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("#")
            }
            Button {
                x: 471; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("%")
            }
            Button {
                x: 564; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("^")
            }
            Button {
                x: 657; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("*")
            }
            Button {
                x: 750; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("+")
            }
            Button {
                x: 843; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey("=")
            }
            Button {
                x: 937; y: 10; height: 75; width: 80
                onClicked: Keyboard.sendKey(":backspace")
            }

    // second raw
            Button {
                x: 44; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("_")
            }

            Button {
                x: 136; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("\\")
            }

            Button {
                x: 228; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("|")
            }

            Button {
                x: 320; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("~")
            }

            Button {
                x: 412; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey("<")
            }
            Button {
                x: 504; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey(">")
            }
            Button {
                x: 596; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey(":eurosign")
            }
            Button {
                x: 688; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey(":sterling")
            }
            Button {
                x: 780; y: 96; height: 75; width: 80
                onClicked: Keyboard.sendKey(":yen")
            }
            Button {
                type: "return"
                x: 872; y: 96; height: 75; width: 146
                onClicked: Keyboard.sendKey(":enter")
            }

// third raw
            Button {
                x: 6; y: 182; height: 75; width: 80
                onClicked: { layout_numeric.visible = true; layout_punctuation.visible = false; } 
            }
            Button {
                type: "undo"
                x: 98; y: 182; height: 75; width: 170
                onClicked: Keyboard.sendKey(":redo")
            }
            Button {
                x: 278; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey(".")
            }
            Button {
                x: 368; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey(",")
            }
            Button {
                x: 459; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("?")
            }
            Button {
                x: 550; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("!")
            }
            Button {
                x: 640; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey("'")
            }
            Button {
                x: 731; y: 182; height: 75; width: 80
                onClicked: Keyboard.sendKey('"')
            }

            Button {
                type: "rightshift"
                x: 911; y: 182; height: 75; width: 107
                onClicked: { layout_numeric.visible = true; layout_punctuation.visible = false; } 
            }

// forth raw

            Button {
                type: "leftpun"
                x: 6; y: 268; height: 75; width: 124
                onClicked: { layout_default.visible = true; layout_punctuation.visible = false; } 
            }

            Button {
                type: "leftpun"
                x: 142; y: 268; height: 75; width: 124
                onClicked: { layout_default.visible = true; layout_punctuation.visible = false; } 
            }

            Button {
                type: "space"
                x: 278; y: 268; height: 75; width: 441
                onClicked: Keyboard.sendKey(" ")
            }

            Button {
                type: "rightpun"
                x: 731; y: 268; height: 75; width: 196
                onClicked: { layout_default.visible = true; layout_punctuation.visible = false; } 
            }

            Button {
                x: 939; y: 268; height: 75; width: 196
                onClicked: hide.start(); // Keyboard.sendKey(":hide")
            }
        }
    }

    Rectangle {
        id: layout_bpmf
        visible: false

        Image {
            source: ":image/keyboard-bpmf.png"
        }
    }

}
