import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? textColor;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = textColor ?? Theme.of(context).textTheme.bodyLarge?.color;
    
    return ListTile(
      leading: Icon(
        icon,
        color: textColor ?? AppColors.greyColor,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
          color: effectiveTextColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: trailing,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
    );
  }
}
