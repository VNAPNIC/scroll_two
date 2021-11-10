import 'package:flutter/material.dart';

typedef ChildBuilder = Widget Function(BuildContext context, int index);

class ScrollTwoController<E> extends ChangeNotifier {
  ScrollTwoController(List<E> values) {
    _bottom.addAll(values);
  }

  final List<E> _top = [];
  final List<E> _bottom = [];

  List<E> get values => _top + _bottom;

  get top => _top;

  get bottom => _bottom;

  clear() {
    _top.clear();
    _bottom.clear();
  }

  add(E data) {
    _bottom.add(data);
    notifyListeners();
  }

  addAll(Iterable<E> iterable) {
    _bottom.addAll(iterable);
  }

  insert(int index, E data) {
    assert(index >= 0 && index <= (_top.length + _bottom.length));

    if (index == 0) {
      _top.insert(index, data);
    } else if (index < _top.length) {
      _top.insert(index, data);
    } else {
      final caculationIndex = index - _top.length;
      _bottom.insert(caculationIndex, data);
    }
  }

  insertAll(int index, Iterable<E> iterable) {
    assert(index >= 0 && index <= (_top.length + _bottom.length));

    if (index == 0) {
      _top.insertAll(index, iterable);
    } else if (index < _top.length) {
      _top.insertAll(index, iterable);
    } else {
      final caculationIndex = index - _top.length;
      _bottom.insertAll(caculationIndex, iterable);
    }
  }

  removeAt(int index) {
    assert(index >= 0 && index < (_top.length + _bottom.length));

    if (index == 0 && _top.isNotEmpty) {
      _top.removeAt(0);
    } else if (index == 0 && _top.isEmpty) {
      _bottom.removeAt(0);
    } else if (index < _top.length) {
      _top.removeAt(index);
    } else {
      final caculationIndex = index - _top.length;
      _bottom.removeAt(caculationIndex);
    }
  }

  update() {
    notifyListeners();
  }

  E get(int index) {
    assert(index >= 0 && index < (_top.length + _bottom.length));
    if (index == 0 && _top.isNotEmpty) {
      return _top[0];
    } else if (index == 0 && _top.isEmpty) {
      return _bottom[0];
    } else if (index < _top.length) {
      return _top[index];
    } else {
      final caculationIndex = index - _top.length;
      return _bottom[caculationIndex];
    }
  }
}

class ScrollTwo<T> extends StatefulWidget {
  final ChildBuilder builder;
  final ScrollTwoController<T> controller;
  final ScrollController scrollController;

  const ScrollTwo(
    this.builder, {
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
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
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
            childCount: controller._top.length,
          ),
        ),
        SliverList(
          key: centerKey,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return widget.builder(context, index);
            },
            childCount: controller._bottom.length,
          ),
        ),
      ],
    );
  }
}
