import 'package:flutter/material.dart';

typedef ChildBuilder = Widget Function(BuildContext context, int index);

class ScrollTwoController<E> extends ChangeNotifier {
  List<E> top = [];
  List<E> bottom = [];

  add(E data) {
    bottom.add(data);
    notifyListeners();
  }

  addAll(Iterable<E> iterable) {
    bottom.addAll(iterable);
    notifyListeners();
  }

  insert(int index, E data) {
    if (index == 0) {
      print('{1}');
      top.insert(index, data);
    } else if (index < top.length) {
      print('{2}');
      top.insert(index, data);
    } else {
      final caculationIndex = index - top.length;
      print('{4} $caculationIndex | $index | ${top.length}');
      bottom.insert(caculationIndex, data);
    }
    notifyListeners();
  }

  insertAll(int index, Iterable<E> iterable) {
    assert(index <= (top.length + bottom.length));

    if (index == 0) {
      print('{1}');
      top.insertAll(index, iterable);
    } else if (index < top.length) {
      print('{2}');
      top.insertAll(index, iterable);
    } else {
      final caculationIndex = index - top.length;
      print('{4} $caculationIndex | $index | ${top.length}');
      bottom.insertAll(caculationIndex, iterable);
    }
    notifyListeners();
  }

  remove(int index) {
    assert(index >=0 && index <= (top.length + bottom.length));

    if (index == 0 && top.isNotEmpty) {
      print('{1}');
      top.removeAt(0);
    } else if (index == 0 && top.isEmpty) {
      bottom.removeAt(0);
    }else if(index<=top.length){
      top.removeAt(index);
    }else{
      final caculationIndex = index - top.length;
      bottom.removeAt(caculationIndex);
    }

    notifyListeners();
  }
}

class ScrollTwo<T> extends StatefulWidget {
  final ChildBuilder builder;
  final ScrollTwoController<T> controller;
  final ScrollController scrollController;

  const ScrollTwo(this.builder, {
    required this.controller,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  @override
  _ScrollTwoState createState() => _ScrollTwoState<T>();
}

class _ScrollTwoState<T> extends State<ScrollTwo<T>> {
  late ScrollController scrollController;
  late ScrollTwoController<T> controller;

  @override
  void initState() {
    scrollController = widget.scrollController;
    controller = widget.controller;
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey('second-sliver-list');
    return CustomScrollView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      center: centerKey,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return widget.builder(context, index);
            },
            childCount: controller.top.length,
          ),
        ),
        SliverList(
          key: centerKey,
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return widget.builder(context, index);
            },
            childCount: controller.bottom.length,
          ),
        ),
      ],
    );
  }
}
