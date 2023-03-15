import 'package:flutter/material.dart';
import '../assets/const.dart';

class AssetImageWidget extends StatelessWidget {
  const AssetImageWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      placeholderAsset,
      fit: BoxFit.cover,
    );
  }
}
