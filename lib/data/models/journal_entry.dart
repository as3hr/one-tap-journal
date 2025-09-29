import 'package:hive/hive.dart';

part 'journal_entry.g.dart';

@HiveType(typeId: 0)
class JournalEntry extends HiveObject {
  @HiveField(0)
  String date;

  @HiveField(1)
  String question;

  @HiveField(2)
  String response;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  DateTime? updatedAt;

  JournalEntry({
    required this.date,
    required this.question,
    required this.response,
    required this.createdAt,
    this.updatedAt,
  });

  JournalEntry copyWith({
    String? date,
    String? question,
    String? response,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return JournalEntry(
      date: date ?? this.date,
      question: question ?? this.question,
      response: response ?? this.response,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
