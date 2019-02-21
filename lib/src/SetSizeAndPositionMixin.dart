import 'package:stagexl/stagexl.dart';

import './RefreshMixin.dart';

mixin SetSizeAndPositionMixin on DisplayObject, RefreshMixin {
  static const String ON_RESIZE = "ON_RESIZE";
  static const EventStreamProvider<Event> _onResize =
      const EventStreamProvider<Event>(ON_RESIZE);
  EventStream<Event> get onResize => _onResize.forTarget(this);

  static const String ON_POSITIONED = "ON_POSITIONED";
  static const EventStreamProvider<Event> _onPositioned =
      const EventStreamProvider<Event>(ON_POSITIONED);
  EventStream<Event> get onPositioned => _onPositioned.forTarget(this);

  num _width = 0;
  num _height = 0;

  int _backgroundColor = 0xff000000;
  int get backgroundColor => _backgroundColor;
  set backgroundColor(int value) {
    _backgroundColor = value;
    refresh();
  }

  @override
  get width => _width;

  @override
  get height => _height;

  @override
  set width(num value) {
    throw Exception("use setSize() instead");
  }

  @override
  set height(num value) {
    throw Exception("use setSize() instead");
  }

  @override
  set x(num value) {
    throw Exception("use setPosition() instead");
  }

  @override
  set y(num value) {
    throw Exception("use setPosition() instead");
  }

  void setPosition(num x, num y) {
    super.x = x;
    super.y = y;
    dispatchEvent(new Event(ON_POSITIONED));
  }

  void setSize(num width, num height) {
    _width = width;
    _height = height;

    refresh();
    dispatchEvent(new Event(ON_RESIZE));
  }
}
