import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/home_controller.dart';
import '../components/question_card.dart';
import '../components/response_input.dart';
import '../components/saved_entry_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'One Tap Journal',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Date Header with Gradient
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.lightBlueColor.withValues(alpha: 0.8),
                      AppColors.lightGreenColor.withValues(alpha: 0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lightBlueColor.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      color: AppColors.whiteColor,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        controller.currentDate.value,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w600,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 36), // Balance the icon
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Question Card
              QuestionCard(question: controller.currentQuestion.value),

              const SizedBox(height: 20),

              // Response Section
              if (controller.hasEntryForToday.value &&
                  !controller.isEditing.value)
                SavedEntryCard(
                  response: controller.userResponse.value,
                  onEdit: controller.startEditing,
                )
              else
                ResponseInput(
                  response: controller.userResponse.value,
                  onChanged: controller.updateResponse,
                  onSave: controller.saveEntry,
                  onCancel: controller.hasEntryForToday.value
                      ? controller.cancelEditing
                      : null,
                  isLoading: controller.isLoading.value,
                  canSave: controller.canSave,
                ),
            ],
          ),
        );
      }),
    );
  }
}
