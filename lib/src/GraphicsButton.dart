import 'package:stagexl/stagexl.dart';
import './HoverBackgroundMixin.dart';
import './RefreshMixin.dart';
import './SetSizeAndPositionMixin.dart';

class GraphicsButton extends Sprite
    with RefreshMixin, HoverBackgroundMixin, SetSizeAndPositionMixin {
  num _padding = 5;
  num get padding => _padding;
  void set padding(num value) {
    _padding = value;

    _inner.x = padding;
    _inner.y = padding;

    refresh();
  }

  Sprite _inner;

  void Function(Graphics graphics, num width, num height) draw;

  GraphicsButton(void Function(Graphics graphics, num width, num height) draw) {
    this.draw = draw;

    _inner = Sprite()
      ..x = padding
      ..y = padding
      ..mouseEnabled = false;
    addChild(_inner);

    onMouseOver.listen((Event e) {
      isHovered = true;
    });

    onMouseOut.listen((Event e) {
      isHovered = false;
    });

    mouseCursor = MouseCursor.POINTER;
    refresh();
  }

  @override
  void refresh() {
    super.refresh();

    _inner.graphics.clear();
    draw(_inner.graphics, width - 2 * padding, height - 2 * padding);
  }
}
