import 'package:stagexl/stagexl.dart';

import './RefreshMixin.dart';
import './SetSizeAndPositionMixin.dart';

class Grid extends Sprite
    with RefreshMixin, SetSizeAndPositionMixin {
  int _columns;
  int _rows;

  List<DisplayObject> _children;

  Grid(int columns, int rows) {
    this._columns = columns;
    this._rows = rows;

    _children = List(columns * rows);
  }

  void removeChildFromGrid(int row, int column) {
    int index = row * _columns + column;

    if (_children[index] != null) {
      removeChild(_children[index]);
    }

    _children[index] = null;
  }

  void addChildToGrid(DisplayObject child, int row, int column) {
    int index = row * _columns + column;

    if (_children[index] != null) {
      removeChild(_children[index]);
    }

    _children[index] = child;

    if (child != null) {
      addChild(child);

      num deltaWidth = width / _columns;
      num deltaHeight = height / _rows;

      if (child is SetSizeAndPositionMixin) {
        child.setPosition(column * deltaWidth, row * deltaHeight);
        child.setSize(deltaWidth, deltaHeight);
      } else {
        child.x = column * deltaWidth;
        child.y = row * deltaHeight;

        child.width = deltaWidth;
        child.height = deltaHeight;
      }
    }
  }

  @override
  void refresh() {
    num deltaWidth = width / _columns;
    num deltaHeight = height / _rows;

    int index = 0;
    for (int row = 0; row < _rows; row++) {
      for (int column = 0; column < _columns; column++) {
        DisplayObject child = _children[index];

        if (child == null) {
          index++;
          continue;
        }

        if (child is SetSizeAndPositionMixin) {
          child.setPosition(column * deltaWidth, row * deltaHeight);
          child.setSize(deltaWidth, deltaHeight);
        } else {
          child.x = column * deltaWidth;
          child.y = row * deltaHeight;

          child.width = deltaWidth;
          child.height = deltaHeight;
        }

        index++;
      }
    }
  }
}
