import 'package:flutter/material.dart';

class FAB extends StatelessWidget {
  final VoidCallback onPressed;

  const FAB({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        key: const ValueKey('FAB'),
        onPressed: onPressed,
        backgroundColor: Colors.amber,
        icon: const Icon(
          Icons.refresh,
          color: Colors.black,
        ),
        label: const Text(
          'REFRESH',
          style: TextStyle(color: Colors.black),
        ));
  }
}
