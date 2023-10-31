// a10935 李志强
// 2023/10/30
// lib/example
import 'dart:math';
import 'package:flutter/cupertino.dart';

class TWLogicTag<T> {
  static final Map<String, List<String>> _tagStack = {};

  static final Map<int, String> _logicTagStack = {};

  static TWLogicTag of<T>({dynamic logic}) {
    return TWLogicTag<T>._(logicKey: logic?.hashCode);
  }

  TWLogicTag._({this.logicKey});

  int? logicKey;

  // "${T}" 的警告不用理会 https://stackoverflow.com/questions/55835258/get-the-name-of-a-dart-class-as-a-type-or-string
  String get _tagKey => "$T";

  /// 获取tag value，用于在各种地方获取controller的时候，比如Get.find(tag:) / GetBuilder(tag:)
  String? get value {
    if (logicKey != null) {
      final val = _logicTagStack[logicKey!];
      if (val != null) {
        debugPrint("TWLogicTag[$_tagKey] get value : $val");
        return val;
      }
    }
    var values = _tagStack[_tagKey] ?? [];
    // 兼容异常情况
    assert(values.isNotEmpty);
    if (values.isEmpty) {
      return newValue;
    }
    var val = values.last;
    debugPrint("TWLogicTag[$_tagKey] get value : $val");
    return val;
  }

  /// 创建新的tag value，用在Get.put(tag:)的时候
  String? get newValue {
    var newVal = "${T}_${Random().nextInt(100000).toString()}";
    var values = _tagStack[_tagKey] ?? [];
    values.add(newVal);
    _tagStack[_tagKey] = values;
    if (logicKey != null) {
      _logicTagStack[logicKey!] = newVal;
    }
    debugPrint(
        "TWLogicTag[$_tagKey] create new tag : $newVal , count: ${values.length}");
    return newVal;
  }

  /// 在controller onClose里调用/或者页面dispose
  void dispose() {
    var values = _tagStack[_tagKey];
    if (values == null) {
      return;
    }

    if (values.isNotEmpty) {
      if (logicKey != null) {
        final value = _logicTagStack[logicKey];
        values.remove(value);
        _logicTagStack.remove(logicKey);
      } else {
        values.removeLast();
      }
    }
    debugPrint("TWLogicTag[$_tagKey] dispose, count: $values.length}");
  }
}
