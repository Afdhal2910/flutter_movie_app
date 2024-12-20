import 'package:flutter/material.dart';
import 'package:test1/app_constants.dart';

class ImageNetworkWidget extends StatelessWidget {
  const ImageNetworkWidget({
    super.key, 
    required this.imageScr, 
    required this.height, 
    required this.width,
    this.radius = 0.0,
  });

  final String imageScr;
  final double height;
  final double width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius), 
      child: Image.network(
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
        ),
    );
  }
}