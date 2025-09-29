import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ResponseInput extends StatefulWidget {
  final String response;
  final Function(String) onChanged;
  final VoidCallback onSave;
  final VoidCallback? onCancel;
  final bool isLoading;
  final bool canSave;

  const ResponseInput({
    super.key,
    required this.response,
    required this.onChanged,
    required this.onSave,
    this.onCancel,
    required this.isLoading,
    required this.canSave,
  });

  @override
  State<ResponseInput> createState() => _ResponseInputState();
}

class _ResponseInputState extends State<ResponseInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.response);
  }

  @override
  void didUpdateWidget(ResponseInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.response != widget.response) {
      _controller.text = widget.response;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Response',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lightBlueColor.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                controller: _controller,
                onChanged: widget.onChanged,
                maxLines: 6,
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: const InputDecoration(
                  hintText: 'Write your thoughts here...',
                  hintStyle: TextStyle(color: AppColors.greyColor),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (widget.onCancel != null) ...[
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.redColor),
                      ),
                      onPressed: widget.isLoading ? null : widget.onCancel,
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.isLoading || !widget.canSave
                        ? null
                        : widget.onSave,
                    child: widget.isLoading
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.whiteColor,
                              ),
                            ),
                          )
                        : const Text('Save Entry'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
