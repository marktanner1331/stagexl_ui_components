import './RefreshMixin.dart';
import 'package:stagexl/stagexl.dart';

mixin HoverBackgroundMixin on Sprite, RefreshMixin {
  int _unhoveredColor = 0xff000000;
  int get unhoveredColor => _unhoveredColor;
  set unhoveredColor(int value) {
    _unhoveredColor = value;
    refresh();
  }

  int _hoveredColor = 0xff333333;
  int get hoveredColor => _hoveredColor;
  set hoveredColor(int value) {
    _hoveredColor = value;
  }

  bool _isHovered = false;
  bool get isHovered => _isHovered;
  void set isHovered(bool value) {
    _isHovered = value;
    refresh();
  }

  @override
  void refresh() {
    
    graphics.clear();

    graphics.beginPath();
    graphics.rect(0, 0, width, height);

    if(_isHovered) {
      graphics.fillColor(_hoveredColor);
    } else {
      graphics.fillColor(_unhoveredColor);
    }

    graphics.closePath();
  }
}
