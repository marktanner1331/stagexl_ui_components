import 'package:stagexl/stagexl.dart';
import './HoverBackgroundMixin.dart';
import './RefreshMixin.dart';
import './SetSizeAndPositionMixin.dart';

class TextButton extends Sprite with RefreshMixin, HoverBackgroundMixin, SetSizeAndPositionMixin {
  bool _autosize = true;
  TextField _label;

  num _padding = 5;
  num get padding => _padding;
  void set padding(num value) {
    _padding = value;
    _refreshInnerSizes();
  }

  TextButton({String text = null}) {
    _label = TextField();
    addChild(_label);

    if (text != null) {
      _label.text = text;
    }

    TextFormat format = _label.defaultTextFormat
      ..align = TextFormatAlign.CENTER
      ..verticalAlign = TextFormatVerticalAlign.CENTER
      ..bold = true
      ..color = 0xffffffff;

    _label.defaultTextFormat = format;
    _label.mouseEnabled = false;
    
    mouseCursor = MouseCursor.POINTER;

    onMouseOver.listen((Event e) {
      isHovered = true;
    });

    onMouseOut.listen((Event e) {
      isHovered = false;
    });

    _refreshInnerSizes();
  }

  int get textColor => _label.textColor;
  set textColor(int value) => _label.textColor = value;

  TextFormat get defaultTextFormat => _label.defaultTextFormat;
  set defaultTextFormat(TextFormat value) {
    _label.defaultTextFormat = value;
    _refreshInnerSizes();
  }

  void _refreshInnerSizes() {
    _label.x =_padding;
    _label.y =_padding;

    if (_autosize) {
      _label.width = _label.textWidth;
      _label.height = _label.textHeight;
      
      super.setSize(_label.width + 2 * _padding, _label.height + 2 * _padding);
    } else {
      _label.width = width - 2 * _padding;
      _label.height = height - 2 * _padding;
    }
  }

  String get text => _label.text;
  void set text(String value) {
    _label.text = value;
    _refreshInnerSizes();
  }

  bool get autosize => _autosize;
  void set autosize(bool value) {
    _autosize = value;
    _refreshInnerSizes();
  }

  @override
  void setSize(num width, num height) {
    if (_autosize) {
      throw Exception("cannot set size when autosize is true");
    }

    super.setSize(width, height);
    _refreshInnerSizes();
  }
}
