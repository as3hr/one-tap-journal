import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:one_tap_journal/modules/history/controllers/history_controller.dart';
import '../../../data/storage_service.dart';
import '../../../data/models/journal_entry.dart';

class HomeController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();

  final RxString currentDate = ''.obs;
  final RxString currentQuestion = ''.obs;
  final RxString userResponse = ''.obs;
  final RxBool hasEntryForToday = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isEditing = false.obs;

  List<String> _questions = [];
  JournalEntry? _todayEntry;

  @override
  void onInit() {
    super.onInit();
    _initializeHome();
  }

  Future<void> _initializeHome() async {
    isLoading.value = true;

    // Set current date
    currentDate.value = DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());

    // Load questions
    await _loadQuestions();

    // Check if entry exists for today
    await _checkTodayEntry();

    // Set today's question
    _setTodaysQuestion();

    isLoading.value = false;
  }

  Future<void> _loadQuestions() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/questions.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      _questions = List<String>.from(jsonData['questions']);
    } catch (e) {
      // Fallback questions if file loading fails
      _questions = [
        "What made you smile today?",
        "What's one thing you're grateful for right now?",
        "Describe your mood in three words.",
        "What was the highlight of your day?",
        "What challenged you today and how did you handle it?",
      ];
    }
  }

  Future<void> _checkTodayEntry() async {
    final todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _todayEntry = _storageService.getJournalEntry(todayKey);

    if (_todayEntry != null) {
      hasEntryForToday.value = true;
      userResponse.value = _todayEntry!.response;
      currentQuestion.value = _todayEntry!.question;
    } else {
      hasEntryForToday.value = false;
      userResponse.value = '';
    }
  }

  void _setTodaysQuestion() {
    if (_todayEntry != null) {
      // Use existing question if entry exists
      currentQuestion.value = _todayEntry!.question;
      return;
    }

    if (_questions.isEmpty) return;

    // Generate a consistent question for today based on date
    final today = DateTime.now();
    final dayOfYear = today.difference(DateTime(today.year, 1, 1)).inDays;
    final questionIndex = dayOfYear % _questions.length;

    currentQuestion.value = _questions[questionIndex];
  }

  Future<void> saveEntry() async {
    if (userResponse.value.trim().isEmpty) {
      Get.snackbar(
        'Empty Response',
        'Please write something before saving.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;

    try {
      final todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final now = DateTime.now();

      final entry = JournalEntry(
        date: todayKey,
        question: currentQuestion.value,
        response: userResponse.value.trim(),
        createdAt: _todayEntry?.createdAt ?? now,
        updatedAt: now,
      );

      await _storageService.saveJournalEntry(entry);
      _todayEntry = entry;
      hasEntryForToday.value = true;
      isEditing.value = false;

      Get.snackbar(
        'Saved!',
        'Your journal entry has been saved.',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.find<HistoryController>().loadEntries();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save entry. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void startEditing() {
    isEditing.value = true;
  }

  void cancelEditing() {
    if (_todayEntry != null) {
      userResponse.value = _todayEntry!.response;
    }
    isEditing.value = false;
  }

  void updateResponse(String value) {
    userResponse.value = value;
  }

  String get todayKey => DateFormat('yyyy-MM-dd').format(DateTime.now());

  bool get canSave => userResponse.value.trim().isNotEmpty;
}
