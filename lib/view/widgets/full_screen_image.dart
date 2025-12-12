import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../utils/constants/colors.dart';
import 'custom_app_bar.dart';

class FullScreenImage extends StatelessWidget {
  List<String> images;
  FullScreenImage({super.key, required this.images,});

  PageController pageController = PageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Uploaded Images', textColor: Colors.white, backgroundColor: AppColors.primary,),
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: '',
            child: PhotoViewGallery.builder(
              backgroundDecoration: const BoxDecoration(color: AppColors.primary2),
              itemCount: images.length,
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(images[index]),
                );
              },
              pageController: pageController,
              onPageChanged: (index) {},
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}