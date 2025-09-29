import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class QuestionCard extends StatelessWidget {
  final String question;

  const QuestionCard({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.lightYelloColor.withValues(alpha: 0.3),
            AppColors.lightBlueColor2.withValues(alpha: 0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightYelloColor.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.lightYelloColor.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.psychology_rounded,
                  size: 32,
                  color: AppColors.greyishBlackColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Today's Question",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                  color: AppColors.greyishBlackColor,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                question,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 18,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
