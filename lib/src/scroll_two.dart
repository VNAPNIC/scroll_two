part of scroll_two;

typedef ChildBuilder = Widget Function(BuildContext context, int index);
typedef IndexCallback = Function(int previous, int current);

Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;

class ScrollTwoController extends ScrollController {
  IndexCallback? _indexCallback;

  ///Fixed too many items won't scroll to the top
  Future<void> moveToMin(double offset,
      {required Duration duration, required Curve curve}) async {
    await animateTo(position.minScrollExtent, duration: duration, curve: curve);
    await animateTo(position.minScrollExtent, duration: duration, curve: curve);
  }

  ///Fixed too many items won't scroll to the bottom
  Future<void> moveToMax(double offset,
      {required Duration duration, required Curve curve}) async {
    await animateTo(position.maxScrollExtent, duration: duration, curve: curve);
    await animateTo(position.maxScrollExtent, duration: duration, curve: curve);
  }

  addVisibilityDetector(IndexCallback? callback) {
    _indexCallback = callback;
  }
}

class DataController<E> extends ChangeNotifier {
  DataController(List<E> values) {
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
  final DataController<T> controller;
  final ScrollTwoController scrollController;

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
  late ScrollTwoController scrollController;
  late DataController<T> controller;
  var previousPostion = 0;
  var currentPostion = 0;

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
              final caculationCurrentIndex = controller.values.length -
                  controller._bottom.length -
                  index -
                  1;
              return VisibilityDetector(
                key: const Key('ScrollTwo'),
                onVisibilityChanged: (visibilityInfo) {
                  var visiblePercentage = visibilityInfo.visibleFraction * 100;
                  if (visiblePercentage >= 1) {
                    indexCallback(caculationCurrentIndex);
                  }
                },
                child: widget.builder(context, caculationCurrentIndex),
              );
            },
            semanticIndexCallback: (_, index) {},
            childCount: controller._top.length,
          ),
        ),
        SliverList(
          key: centerKey,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final caculationCurrentIndex = controller._top.length + index;
              return VisibilityDetector(
                key: const Key('ScrollTwo'),
                onVisibilityChanged: (visibilityInfo) {
                  var visiblePercentage = visibilityInfo.visibleFraction * 100;
                  if (visiblePercentage >= 1) {
                    indexCallback(caculationCurrentIndex);
                  }
                },
                child: widget.builder(context, caculationCurrentIndex),
              );
            },
            semanticIndexCallback: (widget, index) {
              return index;
            },
            childCount: controller._bottom.length,
          ),
        ),
      ],
    );
  }

  indexCallback(index) {
    currentPostion = index;
    if (scrollController._indexCallback != null) {
      scrollController._indexCallback!(previousPostion, currentPostion);
    }
    previousPostion = currentPostion;
  }
}
