import 'dart:async';
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'package:ui_components/ui_components.dart';
import 'dart:math';

Stage stage;

Future<Null> main() async {
  StageOptions options = StageOptions()
    ..backgroundColor = Color.White
    ..stageScaleMode = StageScaleMode.NO_SCALE
    ..stageAlign = StageAlign.TOP_LEFT
    ..renderEngine = RenderEngine.WebGL;

  var canvas = html.querySelector('#stage');
  stage = Stage(canvas, width: 1280, height: 800, options: options);

  var renderLoop = RenderLoop();
  renderLoop.addStage(stage);

  Grid grid = Grid(2, 2);
  grid.setSize(250, 200);
  stage.addChild(grid);

  grid.addChildToGrid(
      TextButton()
        ..text = "click"
        ..autosize = false,
      0,
      0);

  grid.addChildToGrid(
      GraphicsButton((Graphics graphics, num width, num height) {
    graphics.circle(width / 2, height / 2, min(width, height) / 2);
    graphics.fillColor(0xffffffff);
  }), 0, 1);
}
