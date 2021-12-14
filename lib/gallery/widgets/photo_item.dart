
import 'package:flutter/material.dart';
import 'package:flutter_sample_redux/gallery/redux/model/photo_entity.dart';

class PhotoItem extends StatelessWidget {
  final PhotoEntity photo;
  final double? cacheWidth;
  final double? height;
  final double borderRadiusValue;
  final Function()? onTap;

  const PhotoItem({
    Key? key,
    required this.photo,
    this.onTap,
    this.cacheWidth,
    this.height,
    this.borderRadiusValue = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: photo,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.translucent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadiusValue),
          child: Container(
            color: Colors.grey,
            child: Image.network(
              photo.imageUrl,
              fit: BoxFit.cover,
              cacheWidth: cacheWidth != null ? cacheWidth!.toInt() : 350,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const Center(child: Text('loading'));
                }

                return child;
              },
              errorBuilder: (context, error, stackTrace) {
                if (photo.imageUrl.contains('.svg')) {
                  return const Center(child: Text('svg'));
                }

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
