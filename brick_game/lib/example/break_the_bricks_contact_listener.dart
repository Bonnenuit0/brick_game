// a10935 李志强
// 2023/10/30
// lib
import 'dart:developer';
import 'package:brick_game/example/break_the_bricks_logic.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BreakTheBricksContactListener extends ContactListener {
  final BreakTheBricksLogic logic;

  BreakTheBricksContactListener(this.logic);

  @override
  void beginContact(Contact contact) {
    // 处理碰撞开始事件
    // contact包含碰撞的详细信息，例如碰撞的夹具、碰撞点等
  }

  @override
  void endContact(Contact contact) {
    // 处理碰撞结束事件
    // log("endContact++++++++");
  }

  @override
  void preSolve(Contact contact, Manifold oldManifold) {
    // 在解决碰撞之前处理事件
    // log("preSolve++++++++");

  }

  @override
  void postSolve(Contact contact, ContactImpulse impulse) {
    // 在解决碰撞之后处理事件
    // log("postSolve++++++++");
    final fixtureA = contact.fixtureA;
    final fixtureB = contact.fixtureB;

    final bodyA = fixtureA.body;
    final bodyB = fixtureB.body;
    if (bodyA.userData is String && bodyB.userData is String) {
      String stringA = bodyA.userData as String;
      String stringB = bodyB.userData as String;
      if ((stringA == "ball" && stringB == "move") ||
          (stringA == "move" && stringB == "ball")) {
        bodyB.linearVelocity = Vector2(
            bodyB.linearVelocity.x - logic.state.force.x,
            bodyB.linearVelocity.y - logic.state.force.y.abs());
      }

      if ((stringA == "ball" && stringB == "brick") ||
          (stringA == "brick" && stringB == "ball")) {
        FlameAudio.play("collision.mp3");
        if (stringA == "brick") {
          logic.state.bodys.add(bodyA);
        }
        if (stringB == "brick") {
          logic.state.bodys.add(bodyA);
        }
      }
    }
  }
}
