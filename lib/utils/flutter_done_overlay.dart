import 'package:cannabis_calculator/utils/keyboard_done_widget.dart';
import 'package:flutter/material.dart';

class KeyboardOverlay {
  static OverlayEntry _overlayEntry;

  static showOverlay(BuildContext context) {
    if(_overlayEntry != null) {
      return;
    }

    OverlayState overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          bottom: MediaQuery.of(context).viewInsets.top,
          right: 0.0,
          left: 0.0,
          child: InputDoneView());
    });

    overlayState.insert(_overlayEntry);
  }

  static removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry.remove();
      _overlayEntry = null;
    }
  }
}
