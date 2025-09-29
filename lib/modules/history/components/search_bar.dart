import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class HistorySearchBar extends StatefulWidget {
  final String searchQuery;
  final Function(String) onChanged;
  final VoidCallback onClear;

  const HistorySearchBar({
    super.key,
    required this.searchQuery,
    required this.onChanged,
    required this.onClear,
  });

  @override
  State<HistorySearchBar> createState() => _HistorySearchBarState();
}

class _HistorySearchBarState extends State<HistorySearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.searchQuery);
  }

  @override
  void didUpdateWidget(HistorySearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      _controller.text = widget.searchQuery;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: 'Search your entries...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: widget.searchQuery.isNotEmpty
          ? IconButton(
              onPressed: () {
                _controller.clear();
                widget.onClear();
              },
              icon: const Icon(Icons.clear),
            )
          : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).brightness == Brightness.light
          ? AppColors.whiteColor
          : AppColors.greyishBlackColor.withOpacity(0.3),
      ),
    );
  }
}
