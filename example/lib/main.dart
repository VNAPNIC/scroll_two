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
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ScrollTwo(
                  (context, index) {
                    Random random = Random();
                    int min = 50, max = 150;
                    double result = (min + random.nextInt(max - min)).toDouble();
                    return Container(
                      margin: const EdgeInsets.all(8),
                      height: result,
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          'Index ${controller.values[index]}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                  controller: controller,
                  scrollController: scrollController),
            ),
            Column(
              children: [
                Row(
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
            )
          ],
        ),
      ),
    );
  }

  List<int> generateNewData() {
    List<int> values = [];
    final min = controller.values.length+1;
    for (int i = min; i < (min + 20); i++) {
      values.add(i);
    }
    return values;
  }
}
