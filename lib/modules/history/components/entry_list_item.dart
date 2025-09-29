import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/journal_entry.dart';

class EntryListItem extends StatelessWidget {
  final JournalEntry entry;
  final VoidCallback onDelete;
  final String Function(String) formatDate;
  final String Function(String) getRelativeDate;

  const EntryListItem({
    super.key,
    required this.entry,
    required this.onDelete,
    required this.formatDate,
    required this.getRelativeDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date and Actions Row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getRelativeDate(entry.date),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.lightBlueColor,
                        ),
                      ),
                      Text(
                        formatDate(entry.date),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.pinkishRustColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: onDelete,
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: AppColors.pinkishRustColor,
                    ),
                    tooltip: 'Delete entry',
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Question
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.lightYelloColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                entry.question,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Response
            Text(
              entry.response,
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            
            // Show full response if it's truncated
            if (entry.response.length > 150) ...[
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _showFullEntry(context),
                child: Text(
                  'Read more...',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.lightBlueColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showFullEntry(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(getRelativeDate(entry.date)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.lightYelloColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  entry.question,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(entry.response),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
