import 'package:flutter/cupertino.dart';

class ScreenshotItem extends StatelessWidget {
  final String imageUrl;

  const ScreenshotItem({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}