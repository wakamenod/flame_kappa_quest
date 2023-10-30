import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'kappa_quest.dart';

void main() {
  runApp(
    const GameWidget<KappaQuestGame>.controlled(
      gameFactory: KappaQuestGame.new,
    ),
  );
}
