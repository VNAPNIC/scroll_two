import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scroll_two/scroll_two.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ScrollTwoController scrollController;
  late DataController<int> controller;
  int previous = 0;
  int current = 0;

  @override
  void initState() {
    List<int> values = [];
    for (int i = 0; i < 20; i++) {
      values.add(i);
    }
    scrollController = ScrollTwoController();
    controller = DataController<int>(values);

    scrollController.addVisibilityDetector((int previous, int current) {
      print('-------> previous $previous | current $current');
      this.previous = previous;
      this.current = current;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text('previous: $previous current: $current'),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ScrollTwo((context, index) {
                return Container(
                  margin: const EdgeInsets.all(8),
                  height: 50,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Index ${controller.values[index]}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }, controller: controller, scrollController: scrollController),
            ),
            Container(
              color: Colors.deepOrangeAccent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.addAll(generateNewData());
                          controller.update();
                        },
                        child: const Text('Add To bottom'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.insertAll(0, generateNewData());
                          controller.update();
                        },
                        child: const Text('Add To top'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await controller.clear();
                          controller.update();
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await scrollController.moveToMin(
                            scrollController.position.minScrollExtent,
                            duration: const Duration(seconds: 1),
                            curve: Curves.ease,
                          );
                        },
                        child: const Text('Scroll To top'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await scrollController.moveToMax(
                            scrollController.position.maxScrollExtent,
                            duration: const Duration(seconds: 1),
                            curve: Curves.ease,
                          );
                        },
                        child: const Text('Scroll To bottom'),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<int> generateNewData() {
    List<int> values = [];
    final min = controller.values.length + 1;
    for (int i = min; i < (min + 20); i++) {
      values.add(i);
    }
    return values;
  }
}
