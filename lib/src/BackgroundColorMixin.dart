import './RefreshMixin.dart';

mixin BackgroundColorMixin on RefreshMixin {
 int _backgroundColor = 0xff000000;
  int get backgroundColor => _backgroundColor;
  set backgroundColor(int value) {
    _backgroundColor = value;
    refresh();
  }
}