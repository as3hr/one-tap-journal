📝 One Tap Journal

A minimal daily journaling app built with Flutter.
The idea: answer one simple question each day with a short thought and build a habit of reflection, gratitude, and mindfulness.

I made this app in just 1 hour when I had some free time ⚡ — simple, lightweight, and useful!

✨ Features

📅 Daily prompt → one question per day to guide your reflection

✍️ One-line journaling → fast, light, and distraction-free

🕒 History view → revisit all your past entries in list or calendar

🎨 Clean & calming UI → built with soft colors and modern design

🌙 Dark / Light theme toggle

🔔 Optional daily reminder (never miss a day)
	
	
🛠 Tech Stack

Flutter (Dart)

GetX for state management

Hive / SharedPreferences for local storage

intl for date formatting

🎨 Theme Colors

The app uses a warm, calming palette defined in core/theme/app_colors.dart:

Beige: #FCF4EB

Light Green: #5FE8B5

Light Blue: #6EC1E4

Pink Accent: #FF6B6B

Dark / Light variants

🚀 Getting Started

Clone the repo:

git clone https://github.com/your-username/one-tap-journal.git
cd one-tap-journal


Install dependencies:

flutter pub get


Run the app:

flutter run


Build release:

flutter build apk --release

📦 Folder Structure
lib/
 ├── core/
 │    ├── theme/
 │    │    └── app_colors.dart
 │    ├── widgets/        # reusable shared widgets
 │
 ├── modules/
 │    ├── home/           # Home (daily prompt)
 │    ├── history/        # History (list/calendar)
 │    ├── settings/       # Settings (theme toggle, export)
 │
 ├── data/
 │    └── storage_service.dart
 │
 └── main.dart

📱 Play Store

👉 Link to Play Store
 (add once published)

🤝 Contributing

Contributions, issues, and feature requests are welcome!
Feel free to fork this repo and submit pull requests.