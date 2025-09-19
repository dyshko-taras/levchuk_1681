// path: lib/ui/widgets/fields/notes_text_field.dart
// Notes text input with design system styling for Match Details.
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class NotesTextField extends StatefulWidget {
  const NotesTextField({
    required this.value,
    required this.onChanged,
    required this.onSubmit,
    super.key,
    this.hintText,
    this.maxLines = 8,
    this.minLines = 3,
    this.enabled = true,
  });

  final String? value;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSubmit;
  final String? hintText;
  final int maxLines;
  final int minLines;
  final bool enabled;

  @override
  State<NotesTextField> createState() => _NotesTextFieldState();
}

class _NotesTextFieldState extends State<NotesTextField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  String? _lastReportedValue;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? '');
    _focusNode = FocusNode();
    _lastReportedValue = widget.value;
    _controller.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(covariant NotesTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newValue = widget.value ?? '';
    if (newValue != _controller.text) {
      _controller
        ..text = newValue
        ..selection = TextSelection.collapsed(offset: newValue.length);
      _lastReportedValue = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleControllerChanged() {
    final current = _controller.text;
    if (current == _lastReportedValue) {
      return;
    }
    _lastReportedValue = current;
    widget.onChanged?.call(current);
  }

  void _handleSubmitted(String value) {
    _lastReportedValue = value;
    widget.onSubmit?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const border = OutlineInputBorder(
      borderRadius: AppRadius.noteRadius,
      borderSide: BorderSide(
        color: AppColors.borderGray,
      ),
    );
    final isMultiline = widget.maxLines > 1;

    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      enabled: widget.enabled,
      keyboardType: TextInputType.multiline,
      textInputAction: isMultiline
          ? TextInputAction.newline
          : TextInputAction.done,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textWhite),
      cursorColor: AppColors.warningYellow,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: AppColors.textGray,
        ),
        filled: true,
        fillColor: AppColors.cardDark,
        contentPadding: const EdgeInsets.all(AppSpacing.md),
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: const BorderSide(
            color: AppColors.warningYellow,
          ),
        ),
      ),
      onSubmitted: _handleSubmitted,
      onEditingComplete: widget.onSubmit,
    );
  }
}
