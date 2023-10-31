// import 'package:flame/components.dart';
// import 'package:flame/experimental.dart';
// import 'package:flame/game.dart';
// import 'package:flame_forge2d/flame_forge2d.dart';
// import 'package:flutter/widgets.dart';
//
// void main() {
//   runApp(GameWidget(game: Forge2DExample()));
// }
//
// class Forge2DExample extends Forge2DGame {
//   @override
//   Future<void> onLoad() async {
//     add(Ball(size / 2));
//     addAll(createBoundaries());
//
//     return super.onLoad();
//   }
//
//   List<Component> createBoundaries() {
//     final topLeft = Vector2.zero();
//     final bottomRight = screenToWorld(camera.viewport.effectiveSize);
//     final topRight = Vector2(bottomRight.x, topLeft.y);
//     final bottomLeft = Vector2(topLeft.x, bottomRight.y);
//
//     return [
//       Wall(topLeft, topRight),
//       Wall(topRight, bottomRight),
//       Wall(bottomLeft, bottomRight),
//       Wall(topLeft, bottomLeft)
//     ];
//   }
// }
//
// class Ball extends BodyComponent with TapCallbacks {
//   final Vector2 _position;
//
//   Ball(this._position);
//
//   @override
//   Body createBody() {
//     final shape = CircleShape();
//     shape.radius = 5;
//
//     final fixtureDef = FixtureDef(
//       shape,
//       restitution: 0.8,
//       density: 1.0,
//       friction: 0.4,
//     );
//
//     final bodyDef = BodyDef(
//       userData: this,
//       angularDamping: 0.8,
//       position: _position,
//       type: BodyType.dynamic,
//     );
//
//     return world.createBody(bodyDef)..createFixture(fixtureDef);
//   }
//
//   @override
//   void onTapDown(_) {
//     body.applyLinearImpulse(Vector2.random() * 5000);
//   }
// }
//
// class Wall extends BodyComponent {
//   final Vector2 _start;
//   final Vector2 _end;
//
//   Wall(this._start, this._end);
//
//   @override
//   Body createBody() {
//     final shape = EdgeShape()..set(_start, _end);
//     final fixtureDef = FixtureDef(shape, friction: 0.3);
//     final bodyDef = BodyDef(
//       userData: this,
//       position: Vector2.zero(),
//     );
//
//     return world.createBody(bodyDef)..createFixture(fixtureDef);
//   }
// }

import 'dart:developer';
import 'dart:math' as math;
import 'package:brick_game/example/break_the_bricks_page.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


void main() {
  runApp(const BreakTheBricksPage());
}


// MyContactListener call = MyContactListener();
// Forge2DExample game = Forge2DExample(contactListener: call);
// List<Body> bodys = [];
// MoveBodyComponent move = MoveBodyComponent(Colors.yellow,);
// Ball ball = Ball(getRandomColor());
// Vector2 force = Vector2(0, 0);
// void main() {
//   runApp(SafeArea(
//       child: GameWidget.controlled(gameFactory: () {
//         return game;
//       })));
// }
//
// class Forge2DExample extends Forge2DGame with TapCallbacks,PanDetector {
//   Forge2DExample(
//       {super.contactListener,super.world}
//       );
//   @override
//   Future<void> onLoad() async {
//     await super.onLoad();
//
//     // camera.viewfinder.scale = Vector2(1, 1);
//     camera.viewport.add(FpsTextComponent());
//     world.add(ball);
//     world.addAll(createBoundaries());
//     world.add(move);
//   }
//
//   List<Component> createBoundaries() {
//     final visibleRect = camera.visibleWorldRect;
//     final topLeft = visibleRect.topLeft.toVector2();
//     final topRight = visibleRect.topRight.toVector2();
//     final bottomRight = visibleRect.bottomRight.toVector2();
//     final bottomLeft = visibleRect.bottomLeft.toVector2();
//
//     return [
//       Wall(topLeft, topRight),
//       Wall(topRight, bottomRight),
//       Wall(bottomLeft, bottomRight),
//       Wall(topLeft, bottomLeft),
//     ];
//   }
//
// //   @override
// //   void onTapDown(TapDownEvent event) {
// //     super.onTapDown(event);
// //
// // // 根据相机的位置和缩放，将屏幕坐标转换为游戏世界坐标
// //     Vector2 position = event.canvasPosition - camera.viewport.size / 2;
// //     Vector2 worldPoint = Vector2(position.x / camera.viewfinder.scale.x,
// //         position.y / camera.viewfinder.scale.y);
// //     log("worldPoint++++++++++$worldPoint");
// //     world.add(Ball(getRandomColor(),initialPosition: worldPoint));
// //   }
//
//   @override
//   void handlePanDown(DragDownDetails details) {
//     onPanDown(DragDownInfo.fromDetails(this, details));
//   }
//
//   @override
//   void handlePanStart(DragStartDetails details) {
//     onPanStart(DragStartInfo.fromDetails(this, details));
//   }
//
//   @override
//   void handlePanUpdate(DragUpdateDetails details) {
//     onPanUpdate(DragUpdateInfo.fromDetails(this, details));
//
//     final visibleRect = camera.visibleWorldRect;
//
//     final delta = details.delta/camera.viewfinder.scale.y;
//     final currentPosition = move.body.position;
//     double y = currentPosition.y + delta.dy;
//     if (y <= 0) {
//       y = 0;
//     }
//     if (y >= visibleRect.bottom - 1) {
//       y = visibleRect.bottom - 1;
//     }
//     double x = currentPosition.x + delta.dx;
//     if (x < visibleRect.left + 1) {
//       x = visibleRect.left + 1;
//     }
//     if (x > visibleRect.right - 1) {
//       x = visibleRect.right - 1;
//     }
//     final newPosition = Vector2(x, y);
//     move.body.setTransform(newPosition, move.body.angle);
//     force = Vector2(camera.viewfinder.scale.y * delta.dx *2, camera.viewfinder.scale.y * delta.dy * 2);
//   }
//
//   @override
//   void handlePanEnd(DragEndDetails details) {
//     onPanEnd(DragEndInfo.fromDetails(details));
//   }
//
//   @override
//   void update(double dt) {
//     for (final body in bodys) {
//       for(final compont in world.children) {
//         if (compont is Ball) {
//           Ball ball = compont;
//           if (ball.body == body) {
//             world.children.remove(compont);
//             break;
//           }
//         }
//       }
//
//       world.destroyBody(body);
//     }
//     bodys.clear();
//     world.physicsWorld.stepDt(dt);
//     super.update(dt);
//   }
// }
//
// class Ball extends BodyComponent with TapCallbacks{
//   Color color;
//   Ball(this.color,{Vector2? initialPosition})
//       : super(
//     fixtureDefs: [
//       FixtureDef(
//         CircleShape()..radius = 1,
//         restitution: 0.99,
//         density: 0.5,
//         friction: 0.5,
//       ),
//     ],
//     bodyDef: BodyDef(
//         angularDamping: 0,
//         linearVelocity: Vector2(0,100),
//         position: initialPosition ?? Vector2(0, 0),
//
//         // gravityOverride: Vector2(0, 5),
//         // gravityScale: Vector2(1,-1),
//         type: BodyType.dynamic,
//         userData: "ball"
//     ),
//   );
//
//   @override
//   void render(Canvas canvas) {
//     super.render(canvas);
//     final paint = Paint()..color = color;
//
//     // 在画布上绘制矩形
//     canvas.drawCircle(Offset(0, 0),1,paint);
//   }
//
//
//
// // @override
// // void onTapDown(_) {
// //   body.applyLinearImpulse(Vector2.random() * 5000);
// // }
// }
//
// class Wall extends BodyComponent {
//   final Vector2 _start;
//   final Vector2 _end;
//
//   Wall(this._start, this._end);
//
//   @override
//   Body createBody() {
//     final shape = EdgeShape()..set(_start, _end);
//     final fixtureDef = FixtureDef(shape, friction: 0);
//     final bodyDef = BodyDef(
//         position: Vector2.zero(),
//         userData: "wall"
//     );
//
//     return world.createBody(bodyDef)..createFixture(fixtureDef);
//   }
//
//   // @override
//   // void render(Canvas canvas) {
//   //   // TODO: implement render
//   //   super.render(canvas);
//   //   final paint = Paint()..color = Colors.red;
//   //
//   //   // 在画布上绘制矩形
//   //   canvas.drawLine(Offset(_start.x, _start.y), Offset(_end.x, _end.y), paint);
//   // }
// }
//
// class MoveBodyComponent extends BodyComponent  {
//   Color color;
//   MoveBodyComponent(this.color,{Vector2? initialPosition})
//       : super(
//     fixtureDefs: [
//       FixtureDef(
//         PolygonShape()..setAsBox(5, 0.5, Vector2(0, 0), 0),
//         restitution: 1.0,
//         density: 0.8,
//         friction: 0.5,
//       ),
//     ],
//     bodyDef: BodyDef(
//         angularDamping: 0,
//         position: initialPosition ?? Vector2(0, 20),
//         // gravityOverride: Vector2(0, 100),
//         // gravityScale: Vector2(1,-1),
//         type: BodyType.kinematic,
//         userData: "move"
//     ),
//   );
//
//   @override
//   void render(Canvas canvas) {
//     super.render(canvas);
//     final paint = Paint()..color = color;
//
//     // 在画布上绘制矩形
//     canvas.drawRect(Rect.fromLTRB(-5, -0.5, 5, 0.5),paint);
//   }
//
//
//
// // @override
// // void onTapDown(_) {
// //   body.applyLinearImpulse(Vector2.random() * 5000);
// // }
// }
//
//
// Color getRandomColor() {
//   final random = math.Random();
//   final red = random.nextInt(256);
//   final green = random.nextInt(256);
//   final blue = random.nextInt(256);
//   return Color.fromARGB(255, red, green, blue);
// }
//
//
// class MyContactListener extends ContactListener {
//   @override
//   void beginContact(Contact contact) {
//
//     // 处理碰撞开始事件
//     // contact包含碰撞的详细信息，例如碰撞的夹具、碰撞点等
//   }
//
//   @override
//   void endContact(Contact contact) {
//     // 处理碰撞结束事件
//     // log("endContact++++++++");
//
//   }
//
//   @override
//   void preSolve(Contact contact, Manifold oldManifold) {
//     // 在解决碰撞之前处理事件
//     // log("preSolve++++++++");
//     final fixtureA = contact.fixtureA;
//     final fixtureB = contact.fixtureB;
//
//     final bodyA = fixtureA.body;
//     final bodyB = fixtureB.body;
//     if (bodyA.userData is String && bodyB.userData is String) {
//       String stringA = bodyA.userData as String;
//       String stringB = bodyB.userData as String;
//       if (stringA == "ball" && stringB == "ball") {
//         FlameAudio.play("collision.mp3");
//         // bodys.add(bodyB);
//         bodys.add(bodyA);
//       }
//       if ((stringA == "ball" && stringB == "move") || (stringA == "move" && stringB == "ball")) {
//         bodyB.linearVelocity = Vector2(bodyB.linearVelocity.x - force.x, bodyB.linearVelocity.y - force.y);
//
//         log("$stringB,${bodyB.linearVelocity},${bodyB.angularVelocity},$force");
//
//         log("$stringA,${bodyA.linearVelocity},${bodyA.angularVelocity}");
//
//         log("is move");
//       }
//     }
//
//   }
//
//   @override
//   void postSolve(Contact contact, ContactImpulse impulse) {
//     // 在解决碰撞之后处理事件
//     // log("postSolve++++++++");
//
//   }
// }

