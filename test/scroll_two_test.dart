import 'package:flutter_test/flutter_test.dart';
import 'package:scroll_two/scroll_two.dart';

void main() {
  late ScrollTwoController<int> controller = ScrollTwoController<int>();

  test('Add', () async {
    controller.add(1);
    print('insert top ${controller.top}');
    print('insert bottom ${controller.bottom}');
    expect(controller.bottom.length, 1);
  });

  test('AddAll', () async {
    controller.addAll([2, 3]);
    print('insert top ${controller.top}');
    print('insert bottom ${controller.bottom}');
    expect(controller.bottom.length, 3);
  });

  test('Insert top', () async {
    controller.insert(0, 4);
    print('insert top ${controller.top}');
    print('insert bottom ${controller.bottom}');
    expect(controller.top.length, 1);
  });

  test('Insert bottom', () async {
    controller.insert(1, 5);
    print('insert top ${controller.top}');
    print('insert bottom ${controller.bottom}');
    expect(controller.bottom.length, 4);
  });

  test('Insert all top', () async {
    controller.insertAll(0, [6,7,8,9]);
    expect(controller.top.length, 5);
    print('insert top ${controller.top}');
    print('insert bottom ${controller.bottom}');
    controller.insertAll(1, [10,11,12,13]);
    expect(controller.top.length, 9);
    print('insert top ${controller.top}');
    print('insert bottom ${controller.bottom}');
  });

  test('Insert all bottom', () async {
    controller.insertAll(10, [14,15,16,17]);
    expect(controller.bottom.length, 8);
    print('insert top ${controller.top}');
    print('insert bottom ${controller.bottom}');
    controller.insertAll(13, [18,19,20,21]);
    expect(controller.bottom.length, 12);
    print('insert top ${controller.top}');
    print('insert bottom ${controller.bottom}');
  });

  test('Remove top', () async {
    controller.remove(5);
    expect(controller.bottom.length, 8);
    print('insert top ${controller.top}');
    print('insert bottom ${controller.bottom}');
    controller.insertAll(13, [18,19,20,21]);
    expect(controller.bottom.length, 12);
    print('insert top ${controller.top}');
    print('insert bottom ${controller.bottom}');
  });
}
