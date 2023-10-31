// a10935 李志强
// 2023/10/30
// lib

import 'package:brick_game/example/break_the_bricks_contact_listener.dart';
import 'package:brick_game/example/break_the_bricks_game.dart';
import 'package:brick_game/example/break_the_bricks_logic.dart';
import 'package:brick_game/example/tw_logic_tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class BreakTheBricksPage extends StatefulWidget {
  const BreakTheBricksPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BreakTheBricksPageState();
  }
}

class _BreakTheBricksPageState extends State<BreakTheBricksPage> {

  BreakTheBricksLogic logic = Get.put(
    BreakTheBricksLogic(),
    tag: TWLogicTag.of<BreakTheBricksLogic>().newValue,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    TWLogicTag.of<BreakTheBricksLogic>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return GetBuilder(
    //     tag: TWLogicTag.of<BreakTheBricksLogic>().value,
    //     builder: (controller) {
    //       BreakTheBricksContactListener collisionListener = BreakTheBricksContactListener(logic);
    //       BreakTheBricksGame game = BreakTheBricksGame(logic,contactListener: collisionListener);
    //   return SafeArea(
    //       child: GameWidget.controlled(gameFactory: () {
    //         return game;
    //       }));
    // });
    BreakTheBricksContactListener collisionListener = BreakTheBricksContactListener(logic);
    logic.state.game = BreakTheBricksGame(logic,contactListener: collisionListener);
    return SafeArea(
        child: GameWidget.controlled(gameFactory: () {
          return logic.state.game ?? FlameGame();
        }));
  }
}