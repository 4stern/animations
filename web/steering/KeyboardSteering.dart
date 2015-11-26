part of animations;

class KeyboardSteering extends SteeringConnector {

    static const int keyUp = 87;    // w
    static const int keyDown = 83;  // s
    static const int keyLeft = 65;  // a
    static const int keyRight = 68; // d
    static const int keyFire = 32;  // space

    Map<int, Map<String, Function>> keyMap;

    KeyboardSteering(Fighter fighter, {int up, int down, int left, int right, int fire}) : super(fighter){
        keyMap = {
            up != null    ? up    : keyUp:    {"start": moveForwardStart,  "stop": moveForwardStop},
            down != null  ? down  : keyDown:  {"start": moveBackwardStart, "stop": moveBackwardStop},
            left != null  ? left  : keyLeft:  {"start": leftStart,         "stop": leftStop},
            right != null ? right : keyRight: {"start": rightStart,        "stop": rightStop},
            fire != null  ? fire  : keyFire:  {"start": fireStart,         "stop": fireStop}
        };

        document.body.onKeyDown.listen((KeyEvent event) => handleKeyEvent(event, true));
        document.body.onKeyUp.listen((KeyEvent event) => handleKeyEvent(event, false));
    }

    void handleKeyEvent(KeyEvent event, bool start) {
        var keyEvent = new KeyEvent.wrap(event);
        int code = keyEvent.keyCode;
        if (keyMap.containsKey(code) == true) {
            keyMap[code][ start ? "start" : "stop"]();
        }
    }
}
