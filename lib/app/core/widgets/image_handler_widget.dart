import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'index.dart';

class ImageHandlerWidget extends StatelessWidget {
  final String urlToImage;
  const ImageHandlerWidget({super.key, required this.urlToImage});

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: AspectRatio(
            aspectRatio: 1,
            child: CachedNetworkImage(
              placeholder: (context, url) => const AssetImageWidget(),
              errorWidget: (context, url, error) => const AssetImageWidget(),
              imageUrl: urlToImage,
            ),
          )),
    );
  }
}
