// a10935 李志强
// 2023/10/30
// lib

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BreakTheBricksBall extends BodyComponent {
  Color color;

  BreakTheBricksBall(this.color, {Vector2? initialPosition})
      : super(
          fixtureDefs: [
            FixtureDef(
              CircleShape()..radius = 1,
              restitution: 0.99,
              density: 0.5,
              friction: 0.5,
            ),
          ],
          bodyDef: BodyDef(
              angularDamping: 0,
              linearVelocity: Vector2(0, 100),
              position: initialPosition ?? Vector2(0, 0),
              gravityOverride: Vector2(0,0),
              type: BodyType.dynamic,
              userData: "ball"),
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = color;

    // 在画布上绘制矩形
    canvas.drawCircle(Offset(0, 0), 1, paint);
  }
}
