import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/storage_service.dart';
import '../../../data/models/journal_entry.dart';

class HistoryController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();

  final RxList<JournalEntry> entries = <JournalEntry>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final RxBool isCalendarView = true.obs;
  final Rx<DateTime> selectedDay = DateTime.now().obs;
  final Rx<DateTime> focusedDay = DateTime.now().obs;

  List<JournalEntry> _allEntries = [];
  final Map<DateTime, List<JournalEntry>> _entriesMap = {};

  @override
  void onInit() {
    super.onInit();
    loadEntries();
  }

  Future<void> loadEntries() async {
    isLoading.value = true;

    try {
      _allEntries = _storageService.getAllJournalEntries();
      _buildEntriesMap();
      _filterEntries();
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _buildEntriesMap() {
    _entriesMap.clear();
    for (final entry in _allEntries) {
      try {
        final date = DateTime.parse(entry.date);
        final normalizedDate = DateTime(date.year, date.month, date.day);

        if (_entriesMap[normalizedDate] == null) {
          _entriesMap[normalizedDate] = [];
        }
        _entriesMap[normalizedDate]!.add(entry);
      } catch (e) {
        // Skip invalid dates
      }
    }
  }

  void _filterEntries() {
    if (searchQuery.value.isEmpty) {
      entries.value = _allEntries;
    } else {
      final query = searchQuery.value.toLowerCase();
      entries.value = _allEntries.where((entry) {
        return entry.response.toLowerCase().contains(query) ||
            entry.question.toLowerCase().contains(query) ||
            _formatDate(entry.date).toLowerCase().contains(query);
      }).toList();
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    _filterEntries();
  }

  void clearSearch() {
    searchQuery.value = '';
    _filterEntries();
  }

  Future<void> deleteEntry(JournalEntry entry) async {
    try {
      await _storageService.deleteJournalEntry(entry.date);
      await loadEntries();

      Get.snackbar(
        'Deleted',
        'Journal entry has been deleted.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete entry.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void showDeleteConfirmation(JournalEntry entry) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Entry'),
        content: Text(
          'Are you sure you want to delete the entry from ${_formatDate(entry.date)}?',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              deleteEntry(entry);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('EEEE, MMMM d, yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  String formatEntryDate(String dateString) => _formatDate(dateString);

  String getRelativeDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final entryDate = DateTime(date.year, date.month, date.day);

      final difference = today.difference(entryDate).inDays;

      if (difference == 0) {
        return 'Today';
      } else if (difference == 1) {
        return 'Yesterday';
      } else if (difference < 7) {
        return '$difference days ago';
      } else {
        return DateFormat('MMM d, yyyy').format(date);
      }
    } catch (e) {
      return dateString;
    }
  }

  // Calendar methods
  void toggleView() {
    isCalendarView.value = !isCalendarView.value;
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;
  }

  List<JournalEntry> getEntriesForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return _entriesMap[normalizedDay] ?? [];
  }

  bool hasEntryForDay(DateTime day) {
    return getEntriesForDay(day).isNotEmpty;
  }

  JournalEntry? getSelectedDayEntry() {
    final entries = getEntriesForDay(selectedDay.value);
    return entries.isNotEmpty ? entries.first : null;
  }

  int get totalEntries => _allEntries.length;

  bool get hasEntries => entries.isNotEmpty;
}
