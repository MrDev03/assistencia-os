import 'package:flutter/material.dart';

class Notifier extends ValueNotifier<int> {
  Notifier() : super(0);

  void atualizar() {
    value++;
  }
  void reset() {
    value = 0;
  }
}

final ValueNotifier<bool> isWideScreenNotifier = ValueNotifier(false);

final notifier = Notifier();

final ValueNotifier<void> totalNotifier = ValueNotifier(null);


