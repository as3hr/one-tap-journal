import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/history_controller.dart';
import '../components/search_bar.dart';
import '../components/entry_list_item.dart';
import '../components/empty_history.dart';
import '../components/calendar_view.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Obx(() => IconButton(
            onPressed: controller.toggleView,
            icon: Icon(
              controller.isCalendarView.value 
                ? Icons.list_rounded 
                : Icons.calendar_month_rounded,
              color: AppColors.lightBlueColor,
            ),
            tooltip: controller.isCalendarView.value 
              ? 'Switch to List View' 
              : 'Switch to Calendar View',
          )),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Switch between Calendar and List View
        if (controller.isCalendarView.value) {
          return const CalendarView();
        }

        return Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: HistorySearchBar(
                searchQuery: controller.searchQuery.value,
                onChanged: controller.updateSearchQuery,
                onClear: controller.clearSearch,
              ),
            ),
            
            // Stats
            if (controller.totalEntries > 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreenColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${controller.totalEntries} total entries',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            
            const SizedBox(height: 16),
            
            // Entries List
            Expanded(
              child: controller.hasEntries
                ? RefreshIndicator(
                    onRefresh: controller.loadEntries,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: controller.entries.length,
                      itemBuilder: (context, index) {
                        final entry = controller.entries[index];
                        return EntryListItem(
                          entry: entry,
                          onDelete: () => controller.showDeleteConfirmation(entry),
                          formatDate: controller.formatEntryDate,
                          getRelativeDate: controller.getRelativeDate,
                        );
                      },
                    ),
                  )
                : EmptyHistory(
                    hasSearchQuery: controller.searchQuery.value.isNotEmpty,
                    onClearSearch: controller.clearSearch,
                  ),
            ),
          ],
        );
      }),
    );
  }
}
