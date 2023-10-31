// a10935 李志强
// 2023/10/30
// lib/example

import 'package:flame_forge2d/body_component.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class BreakTheBricksMove extends BodyComponent {
  Color color;
  BreakTheBricksMove(this.color,{Vector2? initialPosition})
      : super(
    fixtureDefs: [
      FixtureDef(
        PolygonShape()..setAsBox(7, 0.5, Vector2(0, 0), 0),
        restitution: 1.0,
        density: 0.8,
        friction: 0.5,
      ),
    ],
    bodyDef: BodyDef(
        angularDamping: 0,
        position: initialPosition ?? Vector2(0, 40),
        type: BodyType.kinematic,
        userData: "move"
    ),
  );

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = color;

    // 在画布上绘制矩形
    canvas.drawRect(const Rect.fromLTRB(-7, -0.5, 7, 0.5),paint);
  }
}
