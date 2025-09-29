import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/settings_controller.dart';
import '../components/settings_section.dart';
import '../components/settings_tile.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // App Stats Card with Gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.lightBlueColor.withValues(alpha: 0.1),
                    AppColors.lightGreenColor.withValues(alpha: 0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Card(
                color: Colors.transparent,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.lightBlueColor.withValues(
                            alpha: 0.2,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.menu_book_rounded,
                          size: 48,
                          color: AppColors.lightBlueColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'One Tap Journal',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${controller.totalEntries} journal entries',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Appearance Section
            SettingsSection(
              title: 'Appearance',
              children: [
                Obx(
                  () => SettingsTile(
                    icon: controller.isDarkMode.value
                        ? Icons.dark_mode_rounded
                        : Icons.light_mode_rounded,
                    title: 'Dark Mode',
                    subtitle: 'Switch between light and dark themes',
                    trailing: CupertinoSwitch(
                      value: controller.isDarkMode.value,
                      onChanged: controller.toggleDarkMode,
                      activeTrackColor: AppColors.lightBlueColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Data Section
            SettingsSection(
              title: 'Data',
              children: [
                Obx(
                  () => SettingsTile(
                    icon: Icons.file_download_rounded,
                    title: 'Export Entries',
                    subtitle: 'Save your journal entries to a text file',
                    trailing: controller.isExporting.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.lightBlueColor,
                              ),
                            ),
                          )
                        : const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    onTap: controller.isExporting.value
                        ? null
                        : controller.exportEntries,
                  ),
                ),
                SettingsTile(
                  icon: Icons.delete_sweep_rounded,
                  title: 'Clear All Data',
                  subtitle: 'Delete all journal entries permanently',
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  ),
                  onTap: controller.showClearDataDialog,
                  textColor: AppColors.pinkishRustColor,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // About Section
            SettingsSection(
              title: 'About',
              children: [
                SettingsTile(
                  icon: Icons.info_rounded,
                  title: 'About App',
                  subtitle: 'Version and app information',
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  ),
                  onTap: controller.showAboutDialog,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Footer
            Text(
              'Made with ❤️ for mindful reflection',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.greyColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
