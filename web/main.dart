import 'dart:async';
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

Stage stage;

Future<Null> main() async {
  StageOptions options = StageOptions()
    ..backgroundColor = Color.White
    ..renderEngine = RenderEngine.WebGL;

  var canvas = html.querySelector('#stage');
  stage = Stage(canvas, width: 1280, height: 800, options: options);

  var renderLoop = RenderLoop();
  renderLoop.addStage(stage);

  stage.onResize.listen(onResize);
  onResize(null);
}

void onResize(Event e) {

}
