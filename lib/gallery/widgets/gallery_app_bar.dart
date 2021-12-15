import 'package:flutter/material.dart';

class GalleryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const GalleryAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xff5808e5),
      bottom: const TabBar(
        indicatorColor: Colors.white,
        tabs: [
          Tab(text: 'New'),
          Tab(text: 'Popular'),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight+ 30);
}
