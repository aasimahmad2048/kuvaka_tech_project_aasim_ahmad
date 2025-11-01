import 'package:flutter/material.dart';
import 'package:riverpod_full_architecture/presentation/ui_constants/app_color.dart';
 
import '../ui_constants/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? icon;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSmall),
      child: TextField(
          
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(color: colorScheme.onBackground),
        decoration: InputDecoration(
          prefixIcon:
              icon != null ? Icon(icon, color: colorScheme.primary) : null,
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.textSecondary),
          filled: true,
          fillColor: colorScheme.surface.withOpacity(0.05),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusMedium),
            borderSide: BorderSide(color: colorScheme.primary.withOpacity(0.4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusMedium),
            borderSide: BorderSide(color: colorScheme.primary, width: 2),
          ),
        ),
      ),
    );
  }
}
