import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  Future<void> alert(String title) async {
    return showDialog(
      context: this,
      builder: (_) => AlertDialog(
        title: Text(title),
        actions: [
          TextButton(onPressed: Navigator.of(this).pop, child: const Text('确定'))
        ],
      ),
    );
  }
}
