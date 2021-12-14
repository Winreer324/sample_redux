
import 'package:flutter/material.dart';
import 'package:flutter_sample_redux/gallery/redux/model/photo_entity.dart';
import 'package:flutter_sample_redux/gallery/widgets/photo_item.dart';

class PhotoList extends StatelessWidget {
  final List<PhotoEntity> photos;
  final ScrollController scrollController;
  final ScrollPhysics physics;

  const PhotoList({
    Key? key,
    required this.photos,
    required this.scrollController,
    this.physics = const AlwaysScrollableScrollPhysics(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      controller: scrollController,
      physics: physics,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 9,
        crossAxisSpacing: 9,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: photos.length,
      itemBuilder: (BuildContext context, int index) {
        final PhotoEntity photo = photos[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: Colors.grey,
            child: PhotoItem(
              photo: photo,
              onTap: () {
                // context.read<PhotoBloc>().add(PhotoItemClicked(photo: photo));
              },
            ),
          ),
        );
      },
    );
  }
}
