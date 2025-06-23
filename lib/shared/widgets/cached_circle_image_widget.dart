import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/color_utils.dart';

class CachedCircleImageWidget extends StatelessWidget {
  final String imageUrl;
  final String fallbackText;
  final double size;

  const CachedCircleImageWidget({
    super.key,
    required this.imageUrl,
    required this.fallbackText,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasImage = imageUrl.isNotEmpty && imageUrl != 'no-image.jpg';

    return SizedBox(
      height: size.h,
      width: size.w,
      child: ClipOval(
        child: hasImage
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator.adaptive(strokeWidth: 1.5),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: getAvatarColor(fallbackText),
                  child: Center(
                    child: Text(
                      fallbackText.isNotEmpty ? fallbackText[0] : '?',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              )
            : Container(
                color: getAvatarColor(fallbackText),
                child: Center(
                  child: Text(
                    fallbackText.isNotEmpty ? fallbackText[0] : '?',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
      ),
    );
  }
}
