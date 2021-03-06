import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scroll_two/scroll_two.dart';

void main() {
  late DataController<int> controller = DataController<int>([]);

  test('Add', () async {
    debugPrint('--------- Add ------------');
    controller.add(1);
    debugPrint('values ${controller.values}');
    expect(controller.bottom.length, 1);

    final result = unOrdDeepEq(controller.values, [1]);
    expect(result, true);
  });

  test('Add all', () async {
    debugPrint('--------- Add all ------------');
    controller.addAll([2, 3]);
    debugPrint('values ${controller.values}');
    expect(controller.bottom.length, 3);

    final result = unOrdDeepEq(controller.values, [1, 2, 3]);
    expect(result, true);
  });

  test('Insert to index 0', () async {
    debugPrint('--------- Insert to the index 0------------');
    controller.insert(0, 4);
    debugPrint('values ${controller.values}');
    expect(controller.top.length, 1);

    final result = unOrdDeepEq(controller.values, [4, 1, 2, 3]);
    expect(result, true);
  });

  test('Insert index 1', () async {
    debugPrint('--------- Insert to the index 1 ------------');
    controller.insert(1, 5);
    debugPrint('values ${controller.values}');
    expect(controller.bottom.length, 4);

    final result = unOrdDeepEq(controller.values, [4, 5, 1, 2, 3]);
    expect(result, true);
  });

  test('Insert all to index 0 and 1', () async {
    debugPrint('--------- Insert all to the index 0 and 1 ------------');
    controller.insertAll(0, [6, 7, 8, 9]);
    expect(controller.top.length, 5);
    debugPrint('values ${controller.values}');

    final result1 = unOrdDeepEq(controller.values, [6, 7, 8, 9, 4, 5, 1, 2, 3]);
    expect(result1, true);

    controller.insertAll(1, [10, 11, 12, 13]);
    expect(controller.top.length, 9);
    debugPrint('values ${controller.values}');

    final result2 = unOrdDeepEq(controller.values, [6, 10, 11, 12, 13, 7, 8, 9, 4, 5, 1, 2, 3]);
    expect(result2, true);
  });

  test('Insert all to index 8 and 12', () async {
    debugPrint('--------- Insert all to the index 8 and 12 ------------');
    controller.insertAll(10, [14, 15, 16, 17]);
    expect(controller.bottom.length, 8);
    debugPrint('values ${controller.values}');

    final result1 = unOrdDeepEq(controller.values, [6, 10, 11, 12, 13, 7, 8, 9, 4, 5, 14, 15, 16, 17, 1, 2, 3]);
    expect(result1, true);

    controller.insertAll(13, [18, 19, 20, 21]);
    expect(controller.bottom.length, 12);
    debugPrint('values ${controller.values}');

    final result2 = unOrdDeepEq(controller.values, [6, 10, 11, 12, 13, 7, 8, 9, 4, 5, 14, 15, 16, 18, 19, 20, 21, 17, 1, 2, 3]);
    expect(result2, true);
  });

  test('Remove at 4', () async {
    debugPrint('--------- Remove at 4 ------------');
    controller.removeAt(4);
    expect(controller.top.length, 8);
    debugPrint('values ${controller.values}');

    final result = unOrdDeepEq(controller.values, [6, 10, 11, 12, 7, 8, 9, 4, 5, 14, 15, 16, 18, 19, 20, 21, 17, 1, 2, 3]);
    expect(result, true);
  });

  test('Remove at 10', () async {
    debugPrint('--------- Remove at 10 ------------');
    controller.removeAt(10);
    expect(controller.bottom.length, 11);
    debugPrint('values ${controller.values}');

    final result = unOrdDeepEq(controller.values, [6, 10, 11, 12, 7, 8, 9, 4, 5, 14, 16, 18, 19, 20, 21, 17, 1, 2, 3]);
    expect(result, true);
  });

  test('Get value 10', () async {
    debugPrint('--------- Get value 10 ------------');
    final value = controller.get(10);
    debugPrint('value $value');
    expect(value, 16);
  });
}
