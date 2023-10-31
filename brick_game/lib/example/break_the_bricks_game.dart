// a10935 李志强
// 2023/10/30
// lib
import 'package:brick_game/example/break_the_bricks_ball.dart';
import 'package:brick_game/example/break_the_bricks_brick.dart';
import 'package:brick_game/example/break_the_bricks_logic.dart';
import 'package:brick_game/example/break_the_bricks_wall.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BreakTheBricksGame extends Forge2DGame with TapCallbacks, PanDetector {
  final BreakTheBricksLogic logic;

  BreakTheBricksGame(this.logic, {super.contactListener, super.world});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // camera.viewfinder.scale = Vector2(1, 1);
    camera.viewport.add(FpsTextComponent());
    world.add(logic.state.ball);
    world.addAll(createBoundaries());
    world.add(logic.state.move);
    world.addAll(logic.state.bricks);
  }

  List<Component> createBoundaries() {
    final visibleRect = camera.visibleWorldRect;
    final topLeft = visibleRect.topLeft.toVector2();
    final topRight = visibleRect.topRight.toVector2();
    final bottomRight = visibleRect.bottomRight.toVector2();
    final bottomLeft = visibleRect.bottomLeft.toVector2();

    double brickWidth = topRight.x * 2 / logic.state.columnNum;
    double brickHeight = logic.state.bricksHeight / logic.state.rowNum;
    for (int row = 0; row < logic.state.rowNum; row++) {
      for (int column = 0; column < logic.state.columnNum; column++) {
        if ((row < column) || column == 6 || column == 3 ){
          continue;
        }
        Vector2 postion = Vector2(topLeft.x + (column + 0.5) * brickWidth,
            topLeft.y + (row + 0.5) * brickHeight);
        logic.state.bricks.add(BreakTheBricksBrick(
            BreakTheBricksLogic.getRandomColor(), brickWidth, brickHeight,
            initialPosition: postion));
      }
    }

    return [
      BreakTheBricksWall(topLeft, topRight),
      BreakTheBricksWall(topRight, bottomRight),
      BreakTheBricksWall(bottomLeft, bottomRight),
      BreakTheBricksWall(topLeft, bottomLeft),
    ];
  }

  @override
  void handlePanDown(DragDownDetails details) {
    onPanDown(DragDownInfo.fromDetails(this, details));
  }

  @override
  void handlePanStart(DragStartDetails details) {
    onPanStart(DragStartInfo.fromDetails(this, details));
  }

  @override
  void handlePanUpdate(DragUpdateDetails details) {
    onPanUpdate(DragUpdateInfo.fromDetails(this, details));

    final visibleRect = camera.visibleWorldRect;

    final delta = details.delta / camera.viewfinder.scale.y;
    final currentPosition = logic.state.move.body.position;
    double y = currentPosition.y + delta.dy;
    if (y <= 0) {
      y = 0;
    }
    if (y >= visibleRect.bottom - 1) {
      y = visibleRect.bottom - 1;
    }
    double x = currentPosition.x + delta.dx;
    if (x < visibleRect.left + 1) {
      x = visibleRect.left + 1;
    }
    if (x > visibleRect.right - 1) {
      x = visibleRect.right - 1;
    }
    final newPosition = Vector2(x, y);
    logic.state.move.body
        .setTransform(newPosition, logic.state.move.body.angle);
    logic.state.force = Vector2(camera.viewfinder.scale.y * delta.dx,
        camera.viewfinder.scale.y * delta.dy * 2);
  }

  @override
  void handlePanEnd(DragEndDetails details) {
    onPanEnd(DragEndInfo.fromDetails(details));

    logic.state.force = Vector2(0,
        0);
  }

  @override
  void update(double dt) {
    for (final body in logic.state.bodys) {
      for (final compont in world.children) {
        if (compont is BreakTheBricksBrick) {
          BreakTheBricksBrick ball = compont;
          if (ball.body == body) {
            world.children.remove(compont);
            break;
          }
        }
      }

      world.destroyBody(body);
    }
    logic.state.bodys.clear();
    world.physicsWorld.stepDt(dt);
    super.update(dt);
  }
}
