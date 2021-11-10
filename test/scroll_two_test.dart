import 'package:flutter_test/flutter_test.dart';
import 'package:scroll_two/scroll_two.dart';

void main() {
  late ScrollTwoController<int> controller = ScrollTwoController<int>([]);

  test('Add', () async {
    print('--------- Add ------------');
    controller.add(1);
    print('top ${controller.top}');
    print('bottom ${controller.bottom}');
    expect(controller.bottom.length, 1);
  });

  test('AddAll', () async {
    print('--------- Add all ------------');
    controller.addAll([2, 3]);
    print('top ${controller.top}');
    print('bottom ${controller.bottom}');
    expect(controller.bottom.length, 3);
  });

  test('Insert top', () async {
    print('--------- Insert top ------------');
    controller.insert(0, 4);
    print('top ${controller.top}');
    print('bottom ${controller.bottom}');
    expect(controller.top.length, 1);
  });

  test('Insert bottom', () async {
    print('--------- Insert bottom ------------');
    controller.insert(1, 5);
    print('top ${controller.top}');
    print('bottom ${controller.bottom}');
    expect(controller.bottom.length, 4);
  });

  test('Insert all top', () async {
    print('--------- Insert all top ------------');
    controller.insertAll(0, [6, 7, 8, 9]);
    expect(controller.top.length, 5);
    print('top ${controller.top}');
    print('bottom ${controller.bottom}');
    controller.insertAll(1, [10, 11, 12, 13]);
    expect(controller.top.length, 9);
    print('top ${controller.top}');
    print('bottom ${controller.bottom}');
  });

  test('Insert all bottom', () async {
    print('--------- Insert all bottom ------------');
    controller.insertAll(10, [14, 15, 16, 17]);
    expect(controller.bottom.length, 8);
    print('top ${controller.top}');
    print('bottom ${controller.bottom}');
    controller.insertAll(13, [18, 19, 20, 21]);
    expect(controller.bottom.length, 12);
    print('top ${controller.top}');
    print('bottom ${controller.bottom}');
  });

  test('Remove top', () async {
    print('--------- Remove top ------------');
    controller.removeAt(4);
    expect(controller.top.length, 8);
    print('top ${controller.top}');
    print('bottom ${controller.bottom}');
  });

  test('Remove Bottom', () async {
    print('--------- Remove top ------------');
    controller.removeAt(10);
    expect(controller.bottom.length, 11);
    print('top ${controller.top}');
    print('bottom ${controller.bottom}');
  });

  test('Get', () async {
    print('--------- Get ------------');
    final value = controller.get(10);
    expect(value, 16);
  });
}
