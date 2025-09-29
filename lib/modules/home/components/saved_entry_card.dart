import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SavedEntryCard extends StatelessWidget {
  final String response;
  final VoidCallback onEdit;

  const SavedEntryCard({
    super.key,
    required this.response,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreenColor.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.lightGreenColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Entry Saved',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.lightGreenColor,
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightBlueColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: onEdit,
                    icon: const Icon(
                      Icons.edit_rounded,
                      color: AppColors.lightBlueColor,
                    ),
                    tooltip: 'Edit entry',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.lightBlueColor2.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                response,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit_rounded),
                label: const Text('Edit Entry'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.lightBlueColor,
                  side: const BorderSide(color: AppColors.lightBlueColor),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
