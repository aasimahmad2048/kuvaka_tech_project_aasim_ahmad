import 'package:flutter/material.dart';
import 'package:riverpod_full_architecture/presentation/ui_constants/text_style.dart';

import '../ui_constants/dimensions.dart'; 

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutlined;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isOutlined ? Colors.transparent : colorScheme.primary,
          foregroundColor: isOutlined ? colorScheme.primary : Colors.white,
          side: isOutlined
              ? BorderSide(color: colorScheme.primary, width: 1.5)
              : BorderSide.none,
          padding: const EdgeInsets.symmetric(
            vertical: Dimensions.paddingMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusMedium),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
            : Text(
                text,
                style: TextStyles.body.copyWith(
                    color: isOutlined ? colorScheme.primary : Colors.white),
              ),
      ),
    );
  }
}
