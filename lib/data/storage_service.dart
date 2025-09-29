import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'models/journal_entry.dart';

class StorageService extends GetxService {
  static const String _journalBoxName = 'journal_entries';
  static const String _settingsBoxName = 'settings';
  
  late Box<JournalEntry> _journalBox;
  late Box _settingsBox;

  Future<StorageService> init() async {
    await Hive.initFlutter();
    
    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(JournalEntryAdapter());
    }
    
    // Open boxes
    _journalBox = await Hive.openBox<JournalEntry>(_journalBoxName);
    _settingsBox = await Hive.openBox(_settingsBoxName);
    
    return this;
  }

  // Journal Entry Methods
  Future<void> saveJournalEntry(JournalEntry entry) async {
    await _journalBox.put(entry.date, entry);
  }

  JournalEntry? getJournalEntry(String date) {
    return _journalBox.get(date);
  }

  List<JournalEntry> getAllJournalEntries() {
    return _journalBox.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> deleteJournalEntry(String date) async {
    await _journalBox.delete(date);
  }

  bool hasEntryForDate(String date) {
    return _journalBox.containsKey(date);
  }

  // Settings Methods
  Future<void> saveSetting(String key, dynamic value) async {
    await _settingsBox.put(key, value);
  }

  T? getSetting<T>(String key, {T? defaultValue}) {
    return _settingsBox.get(key, defaultValue: defaultValue) as T?;
  }

  bool get isDarkMode => getSetting('isDarkMode', defaultValue: false) ?? false;
  
  Future<void> setDarkMode(bool value) async {
    await saveSetting('isDarkMode', value);
  }

  // Export functionality
  String exportEntriesToText() {
    final entries = getAllJournalEntries();
    final buffer = StringBuffer();
    
    buffer.writeln('One Tap Journal Export');
    buffer.writeln('Generated on: ${DateTime.now().toString()}');
    buffer.writeln('=' * 50);
    buffer.writeln();
    
    for (final entry in entries) {
      buffer.writeln('Date: ${entry.date}');
      buffer.writeln('Question: ${entry.question}');
      buffer.writeln('Response: ${entry.response}');
      buffer.writeln('-' * 30);
      buffer.writeln();
    }
    
    return buffer.toString();
  }
}
