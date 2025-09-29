import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_tap_journal/modules/history/controllers/history_controller.dart';
import 'package:path_provider/path_provider.dart';
import '../../../data/storage_service.dart';

class SettingsController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();

  final RxBool isDarkMode = false.obs;
  final RxBool isExporting = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  void _loadSettings() {
    isDarkMode.value = _storageService.isDarkMode;
  }

  Future<void> toggleDarkMode(bool value) async {
    isDarkMode.value = value;
    await _storageService.setDarkMode(value);

    // Update app theme
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> exportEntries() async {
    isExporting.value = true;

    try {
      final historyController = Get.find<HistoryController>();
      final entries = historyController.entries;

      if (entries.isEmpty) {
        Get.snackbar(
          'No Entries',
          'You have no journal entries to export.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final exportText = _storageService.exportEntriesToText();

      // Get the documents directory
      final directory = await getApplicationDocumentsDirectory();
      final fileName =
          'one_tap_journal_export_${DateTime.now().millisecondsSinceEpoch}.txt';
      final file = File('${directory.path}/$fileName');

      // Write the export text to file
      await file.writeAsString(exportText);

      Get.snackbar(
        'Export Successful',
        'Journal entries exported to Documents folder',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
      );
    } catch (e) {
      Get.snackbar(
        'Export Failed',
        'Failed to export journal entries. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isExporting.value = false;
    }
  }

  void showAboutDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('About One Tap Journal'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Version: 1.0.0'),
            SizedBox(height: 8),
            Text(
              'One Tap Journal is a simple and beautiful journaling app that helps you reflect on your day with thought-provoking questions.',
            ),
            SizedBox(height: 12),
            Text('Features:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('• Daily thought-provoking questions'),
            Text('• Local storage for privacy'),
            Text('• Search through your entries'),
            Text('• Export your journal'),
            Text('• Dark/Light theme support'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Close')),
        ],
      ),
    );
  }

  void showClearDataDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text(
          'Are you sure you want to delete all your journal entries? This action cannot be undone.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              _clearAllData();
            },
            child: const Text(
              'Delete All',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _clearAllData() async {
    try {
      final entries = _storageService.getAllJournalEntries();
      for (final entry in entries) {
        await _storageService.deleteJournalEntry(entry.date);
      }

      Get.snackbar(
        'Data Cleared',
        'All journal entries have been deleted.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to clear data. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  int get totalEntries => _storageService.getAllJournalEntries().length;
}
