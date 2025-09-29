import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class EmptyHistory extends StatelessWidget {
  final bool hasSearchQuery;
  final VoidCallback onClearSearch;

  const EmptyHistory({
    super.key,
    required this.hasSearchQuery,
    required this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.lightGrey.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                hasSearchQuery ? Icons.search_off_rounded : Icons.menu_book_outlined,
                size: 64,
                color: AppColors.lightGrey,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              hasSearchQuery 
                ? 'No entries found'
                : 'No journal entries yet',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.greyColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              hasSearchQuery
                ? 'Try adjusting your search terms'
                : 'Start writing your first journal entry from the Home tab',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (hasSearchQuery) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onClearSearch,
                child: const Text('Clear Search'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
