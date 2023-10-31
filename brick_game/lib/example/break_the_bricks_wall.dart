// a10935 李志强
// 2023/10/30
// lib
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BreakTheBricksWall extends BodyComponent {
  final Vector2 _start;
  final Vector2 _end;

  BreakTheBricksWall(this._start, this._end);

  @override
  Body createBody() {
    final shape = EdgeShape()..set(_start, _end);
    final fixtureDef = FixtureDef(shape, friction: 0);
    final bodyDef = BodyDef(
        position: Vector2.zero(),
        userData: "wall"
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

// @override
// void render(Canvas canvas) {
//   super.render(canvas);
//   final paint = Paint()..color = Colors.red;
//
//   // 在画布上绘制矩形
//   canvas.drawLine(Offset(_start.x, _start.y), Offset(_end.x, _end.y), paint);
// }
}