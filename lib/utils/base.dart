import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

logPrint([dynamic log1, dynamic log2, dynamic log3, dynamic log4, dynamic log5]) {
  debugPrint([log1, log2, log3, log4, log5].nonNulls.join(' | '));
}

Future waitFrame() async {
  try {
    if (WidgetsBinding.instance.schedulerPhase != SchedulerPhase.idle) {
      await WidgetsBinding.instance.endOfFrame;
    }
  } catch (e, st) {
    logPrint(e, st);
  }
}

//

Function _disposeFunctionFor(dynamic value) => switch (value) {
  ChangeNotifier _ => value.dispose,
  StreamController _ => value.close,
  AnimationController _ => value.dispose,
  Timer _ => value.cancel,
  null => () {},
  Object() => throw Exception('Undefined dispose!'),
};

mixin DisposableState<S extends StatefulWidget> on State<S> {
  final List<Function> _disposables = [];

  T disposable<T>(T t, [Function? dispose]) {
    _disposables.add((dispose ?? _disposeFunctionFor)(t));
    return t;
  }

  @override
  void dispose() {
    for (Function f in _disposables) {
      f();
    }
    super.dispose();
  }
}

mixin DisposableScope on ChangeNotifier {
  final List<Function> _disposables = [];

  T disposable<T>(T t) {
    _disposables.add(_disposeFunctionFor(t));
    return t;
  }

  void disposableFrom(Function dispose) {
    _disposables.add(dispose);
  }

  @override
  void dispose() {
    for (Function f in _disposables) {
      f();
    }
    super.dispose();
  }
}

class DisposableWidget<T> extends StatefulWidget {
  const DisposableWidget({
    super.key,
    required this.getValue,
    this.disposeFunction = _disposeFunctionFor,
    required this.builder,
  });

  final T Function() getValue;
  final Function Function(T value) disposeFunction;
  final Widget Function(BuildContext context, T value) builder;

  @override
  State<DisposableWidget<T>> createState() => _DisposableWidgetState<T>();
}

class _DisposableWidgetState<T> extends State<DisposableWidget<T>> with DisposableState {
  late final T value = disposable(widget.getValue(), widget.disposeFunction);

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value);
  }
}

extension IterableExt<E> on Iterable<E> {
  Iterable<E> joinWith(E Function(E previous, E next) separator) sync* {
    Iterator<E> iterator = this.iterator;
    if (!iterator.moveNext()) return;

    E previous = iterator.current;
    yield previous;
    if (!iterator.moveNext()) return;

    do {
      yield separator(previous, iterator.current);
      previous = iterator.current;
      yield previous;
    } while (iterator.moveNext());
  }
}

extension RandomExt on Random {
  Offset nextRectPoint(Size size) {
    final side = nextInt(4);
    return switch (side) {
      0 => Offset(nextDouble() * size.width, 0),
      1 => Offset(0, nextDouble() * size.height),
      2 => Offset(nextDouble() * size.width, size.height),
      3 => Offset(size.width, nextDouble() * size.height),
      int() => Offset(0, 0),
    };
  }
}

extension ObjectExt on Object {
  T also<T>(T Function(T) f) {
    return f(this as T);
  }
}

extension ColorExt on Color {
  Color contrastWB() => computeLuminance() > 0.5 ? Colors.black : Colors.white;
}

extension NumExt on num {
  divideBy(num by) => this / by;
  multiplyBy(num by) => this * by;
  add(num a) => this + a;
  subtract(num s) => this - s;
}