import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import '../kappa_quest.dart';

class Kyuri extends SpriteComponent with HasGameRef<KappaQuestGame> {
  final Vector2 gridPosition;
  double xOffset;

  final Vector2 velocity = Vector2.zero();

  Kyuri({
    required this.gridPosition,
    required this.xOffset,
  }) : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  void onLoad() {
    final kyuriImage = game.images.fromCache('m_kyuri.png');
    sprite = Sprite(kyuriImage);
    position = Vector2(
      (gridPosition.x * size.x) + xOffset + (size.x / 2),
      game.size.y - (gridPosition.y * size.y) - (size.y / 2),
    );
    add(RectangleHitbox(collisionType: CollisionType.passive));
    // add(
    //   SizeEffect.by(
    //     Vector2(-24, -24),
    //     EffectController(
    //       duration: .75,
    //       reverseDuration: .5,
    //       infinite: true,
    //       curve: Curves.easeOut,
    //     ),
    //   ),
    // )
    ;
  }

  @override
  void update(double dt) {
    velocity.x = game.objectSpeed;
    position += velocity * dt;
    if (position.x < -size.x) removeFromParent();
    super.update(dt);
  }
}
