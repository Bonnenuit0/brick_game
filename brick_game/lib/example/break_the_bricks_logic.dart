// a10935 李志强
// 2023/10/30
// lib/example

import 'dart:ui';
import 'dart:math' as math;
import 'package:brick_game/example/break_the_bricks_state.dart';
import 'package:get/get.dart';

class BreakTheBricksLogic extends GetxController {
  final BreakTheBricksState state = BreakTheBricksState();

  static Color getRandomColor() {
    final random = math.Random();
    final red = random.nextInt(256);
    final green = random.nextInt(256);
    final blue = random.nextInt(256);
    return Color.fromARGB(255, red, green, blue);
  }
}