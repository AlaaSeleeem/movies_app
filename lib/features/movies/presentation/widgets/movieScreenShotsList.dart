import 'package:flutter/material.dart';
class MovieScreenShotsList extends StatelessWidget {
  List<String> screenshots;
   MovieScreenShotsList({super.key, required this.screenshots});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(screenshots[index], fit: BoxFit.cover, height: 150, width: double.infinity),
            ),
          ),
          childCount: screenshots.length,
        ),
      ),
    );
  }
}
