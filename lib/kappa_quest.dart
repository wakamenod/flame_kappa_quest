import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_tutorials/objects/kyuri.dart';
import 'package:flutter/material.dart';

import 'actors/darma.dart';
import 'actors/kappa.dart';
import 'managers/segment_manager.dart';
import 'objects/ground_block.dart';
import 'objects/platform_block.dart';

class KappaQuestGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  KappaQuestGame();

  @override
  final world = World();

  late final CameraComponent cameraComponent;
  late KappaPlayer _kappa;
  late UniqueKey lastBlockKey;

  late double lastBlockXPosition = 0.0;
  double objectSpeed = 0.0;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'block.png',
      'ground.png',
      'm_kyuri.png',
      'm_kappa.png',
      'm_penki.png',
      'm_mizu.png',
      'm_darma.png',
    ]);

    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, world]);

    initializeGame();
  }

  void initializeGame() {
    // Assume that size.x < 3200
    final segmentsToLoad = (size.x / 640).ceil();
    segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i <= segmentsToLoad; i++) {
      loadGameSegments(i, (640 * i).toDouble());
    }

    _kappa = KappaPlayer(
      position: Vector2(128, canvasSize.y - 128),
    );
    world.add(_kappa);
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset) {
    for (final block in segments[segmentIndex]) {
      switch (block.blockType) {
        case GroundBlock:
          {
            add(GroundBlock(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ));
          }
        case PlatformBlock:
          {
            add(PlatformBlock(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ));
          }
        case Kyuri:
          {
            add(Kyuri(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ));
          }
        case Darma:
          {
            add(Darma(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ));
          }
      }
    }
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 247);
  }
}
