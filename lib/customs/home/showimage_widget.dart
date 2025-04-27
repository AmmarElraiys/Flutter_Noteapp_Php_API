import 'package:flutter/material.dart';

class ShowImageWidget extends StatelessWidget {
  final VoidCallback onCameraPressed;
  final VoidCallback onGalleryPressed;
  final Icon cameraIcon;
  final Icon galleryIcon;

  const ShowImageWidget({
    Key? key,
    required this.onCameraPressed,
    required this.onGalleryPressed,
    required this.cameraIcon,
    required this.galleryIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder:
              (context) => Container(
                padding: const EdgeInsets.all(20),
                height: 200,
                child: Column(
                  children: [
                    const Text(
                      "Choose Image Source",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: onCameraPressed,
                      icon: cameraIcon,
                      label: const Text("Camera"),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: onGalleryPressed,
                      icon: galleryIcon,
                      label: const Text("Gallery"),
                    ),
                  ],
                ),
              ),
        );
      },
      child: const Text("Show Image Options"),
    );
  }
}
