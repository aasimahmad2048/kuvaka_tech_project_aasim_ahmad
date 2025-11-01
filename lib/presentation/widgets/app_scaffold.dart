import 'package:flutter/material.dart';
import '../ui_constants/dimensions.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final bool centerTitle;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: centerTitle,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingMedium),
        child: body,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
