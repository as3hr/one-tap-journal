import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/history_controller.dart';
import 'entry_detail_sheet.dart';

class CalendarView extends GetView<HistoryController> {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          // Calendar Widget
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.lightBlueColor.withValues(alpha: 0.05),
                  AppColors.lightGreenColor.withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lightBlueColor.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: controller.focusedDay.value,
                  selectedDayPredicate: (day) =>
                      isSameDay(controller.selectedDay.value, day),
                  eventLoader: controller.getEntriesForDay,
                  onDaySelected: controller.onDaySelected,
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    weekendTextStyle: const TextStyle(
                      color: AppColors.greyColor,
                    ),
                    holidayTextStyle: const TextStyle(
                      color: AppColors.pinkishRustColor,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: AppColors.lightBlueColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.lightBlueColor.withValues(
                            alpha: 0.3,
                          ),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    todayDecoration: BoxDecoration(
                      color: AppColors.lightGreenColor.withValues(alpha: 0.7),
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: const BoxDecoration(
                      color: AppColors.lightYelloColor,
                      shape: BoxShape.circle,
                    ),
                    markersMaxCount: 1,
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: Theme.of(context).textTheme.headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                    leftChevronIcon: const Icon(
                      Icons.chevron_left_rounded,
                      color: AppColors.lightBlueColor,
                    ),
                    rightChevronIcon: const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.lightBlueColor,
                    ),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w600,
                    ),
                    weekendStyle: TextStyle(
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Selected Day Entry Preview
          _buildSelectedDayPreview(context),
        ],
      ),
    );
  }

  Widget _buildSelectedDayPreview(BuildContext context) {
    final entry = controller.getSelectedDayEntry();

    if (entry == null) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.lightGrey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(
              Icons.event_note_outlined,
              size: 48,
              color: AppColors.lightGrey,
            ),
            const SizedBox(height: 12),
            Text(
              'No entry for this day',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.greyColor),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => _showEntryDetail(context, entry),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.lightBlueColor.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.calendar_today_rounded,
                        color: AppColors.lightBlueColor,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        controller.formatEntryDate(entry.date),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_upward_rounded,
                      color: AppColors.lightBlueColor,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  entry.response,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEntryDetail(BuildContext context, dynamic entry) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EntryDetailSheet(entry: entry),
    );
  }
}
