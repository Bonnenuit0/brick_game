// a10935 李志强
// 2023/10/30
// lib/example

import 'package:brick_game/example/break_the_bricks_ball.dart';
import 'package:brick_game/example/break_the_bricks_brick.dart';
import 'package:brick_game/example/break_the_bricks_game.dart';
import 'package:brick_game/example/break_the_bricks_logic.dart';
import 'package:brick_game/example/break_the_bricks_move.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class BreakTheBricksState {

  late BreakTheBricksBall ball;

  BreakTheBricksGame? game;

  late BreakTheBricksMove move;

  late Vector2 force;

  List<Body> bodys = [];//碰撞后需要移除的body

  List<BreakTheBricksBrick> bricks = [];

  int columnNum = 8;

  int rowNum = 15;

  double bricksHeight = 22;

  BreakTheBricksState() {
    move = BreakTheBricksMove(Colors.yellow,);
    ball = BreakTheBricksBall(Colors.red,);
    force = Vector2(0, 0);
  }
}