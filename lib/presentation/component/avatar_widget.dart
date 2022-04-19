import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum AvatarType { type1, type2, type3 }

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    Key? key,
    required this.thumbPath,
    this.nickname,
    required this.type,
    this.size = 65,
  }) : super(key: key);

  final String? thumbPath;
  final String? nickname;
  final AvatarType type;
  final double size;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AvatarType.type1:
        return type1Widget();
      case AvatarType.type2:
        return type1Widget();
      case AvatarType.type3:
        return type3Widget();
    }
  }

  Widget type1Widget() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, border: Border.all(color: Colors.black26)),
      child: thumbPath != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(65),
              child: SizedBox(
                  width: size,
                  height: size,
                  child: CachedNetworkImage(
                    imageUrl: thumbPath!,
                    fit: BoxFit.cover,
                  )),
            )
          : SizedBox(width: size, height: size, child: const Icon(Icons.person_outline)),
    );
  }

  Widget type3Widget() {
    return Row(
      children: [
        type1Widget(),
        Text(
          nickname ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
