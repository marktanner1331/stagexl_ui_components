import 'package:stagexl/stagexl.dart';
import './RefreshMixin.dart';
import './SetSizeAndPositionMixin.dart';

import 'dart:math';

class VerticalScroller extends Sprite with RefreshMixin, SetSizeAndPositionMixin {
  Sprite _scrollCapture;
  Sprite scrollBar;
  
  EventStreamSubscription<MouseEvent> _stageMouseMoveSubscription;
  EventStreamSubscription<MouseEvent> _stageMouseUpSubscription;

  DisplayObject _content;
  set content(DisplayObject content) {
    _content = content;
    refresh();
  }

  VerticalScroller() {
    _scrollCapture = Sprite();
    _scrollCapture.onMouseDown.listen(_scrollCaptureMouseDown);
    addChild(_scrollCapture);
    
    scrollBar = Sprite();
    addChild(scrollBar);
  }

  void _scrollCaptureMouseDown(MouseEvent e) {
    _stageMouseMoveSubscription = stage.onMouseMove.listen(_stageMouseMove);
    _stageMouseUpSubscription = stage.onMouseUp.listen(_stageMouseUp);
  }

  void _stageMouseMove(MouseEvent e) {
    num mousePercent = _scrollCapture.height / _scrollCapture.mouseY;
    
    _content.y = (height - _content.height) * mousePercent;
    scrollBar.y = (height - scrollBar.height) * mousePercent;
  }

  void _stageMouseUp(MouseEvent e) {
    _stageMouseUpSubscription.cancel();
    _stageMouseMoveSubscription.cancel();
  }

  void refresh() {
    _scrollCapture.graphics.clear();
    _scrollCapture.graphics.beginPath();
    _scrollCapture.graphics.rect(0, 0, 25, height);
    _scrollCapture.graphics.fillColor(0xffff0000);
    _scrollCapture.graphics.closePath();

    _content.width = width - 25;
    if(_content.height > height) {
      scrollBar.visible = true;

      //redraw scrollbar based on size of content
      num scrollbarHeight = (height * height) / _content.height;
      scrollbarHeight = max(scrollbarHeight, 25);

      scrollBar.graphics.clear();
      scrollBar.graphics.moveTo(10, 10);
      scrollBar.graphics.lineTo(10, scrollbarHeight - 10);
      scrollBar.graphics.strokeColor(0xff0000ff, 10);
    } else {
      scrollBar.visible = false;
    }
  }
}