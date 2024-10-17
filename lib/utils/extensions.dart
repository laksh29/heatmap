import 'package:flutter/material.dart';

extension MapIndexed<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E element) transform) sync* {
    int index = 0;
    for (var element in this) {
      yield transform(index, element);
      index++;
    }
  }
}

extension SeparatorExtension on Iterable<Widget> {
  List<Widget> addSeparator(
    Widget separator, {
    int afterEach = 1,
    bool endsWithSeparator = false,
  }) {
    final widgets = <Widget>[...this];

    if (afterEach < 1 || afterEach >= length) return widgets;

    final int totalWidgetsCount = length + (length ~/ afterEach) - 1;

    for (int index = afterEach;
        index < totalWidgetsCount;
        index += (afterEach + 1)) {
      widgets.insert(index, separator);
    }

    if (endsWithSeparator) widgets.add(separator);

    return widgets;
  }
}

extension WhitespaceExtension on num {
  Widget get whitespaceHeight {
    return SizedBox(height: toDouble());
  }

  Widget get whitespaceWidth {
    return SizedBox(width: toDouble());
  }
}
