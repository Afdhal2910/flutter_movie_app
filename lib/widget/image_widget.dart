import 'package:flutter/material.dart';
import 'package:test1/app_constants.dart';

class ImageNetworkWidget extends StatelessWidget {
  const ImageNetworkWidget({
    super.key, 
    required this.imageScr, 
    required this.height, 
    required this.width,
  });

  final String imageScr;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.network(

        '${AppConstants.imageUrlw500}$imageScr',
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return SizedBox(
            height: height,
            width: width,
            child: const Icon(
              Icons.broken_image_rounded,
          ),
        );
        },
      );
  }
}