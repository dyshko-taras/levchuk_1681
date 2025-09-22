// path: lib/ui/widgets/journal/journal_notes_section.dart
// Notes section component for prediction journal.
import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/widgets/buttons/danger_red_button.dart';
import 'package:FlutterApp/ui/widgets/buttons/primary_button.dart';
import 'package:FlutterApp/ui/widgets/buttons/secondary_green_button_light.dart';
import 'package:FlutterApp/ui/widgets/fields/notes_text_field.dart';
import 'package:flutter/material.dart';

class JournalNotesSection extends StatefulWidget {
  const JournalNotesSection({
    required this.events,
    required this.onAddEvent,
    required this.onRemoveEvent,
    super.key,
  });

  final List<String> events;
  final void Function(String) onAddEvent;
  final void Function(String) onRemoveEvent;

  @override
  State<JournalNotesSection> createState() => _JournalNotesSectionState();
}

class _JournalNotesSectionState extends State<JournalNotesSection> {
  final TextEditingController _noteController = TextEditingController();
  bool _isEditing = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final hasNotes = widget.events.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!hasNotes) ...[
          // Add note section
          Row(
            children: [
              Expanded(
                child: NotesTextField(
                  value: _noteController.text,
                  onChanged: (value) => _noteController.text = value,
                  onSubmit: () {
                    final text = _noteController.text.trim();
                    if (text.isNotEmpty) {
                      widget.onAddEvent(text);
                      _noteController.clear();
                    }
                  },
                  hintText: 'Add your notes for this day...',
                  maxLines: 4,
                ),
              ),
              Gaps.wSm,
              PrimaryButton(
                label: 'Add Note',
                onPressed: () {
                  final text = _noteController.text.trim();
                  if (text.isNotEmpty) {
                    widget.onAddEvent(text);
                    _noteController.clear();
                  }
                },
              ),
            ],
          ),
        ] else ...[
          // Display notes section
          Container(
            padding: Insets.allMd,
            decoration: BoxDecoration(
              color: AppColors.cardDark,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.events.first,
                  style: theme.bodyMedium?.copyWith(
                    color: AppColors.textWhite,
                  ),
                ),
                Gaps.hMd,
                Row(
                  children: [
                    Expanded(
                      child: DangerRedButton(
                        label: 'Delete Note',
                        onPressed: () {
                          widget.onRemoveEvent(widget.events.first);
                        },
                      ),
                    ),
                    Gaps.wSm,
                    Expanded(
                      child: SecondaryGreenButtonLight(
                        label: 'Edit Note',
                        onPressed: () {
                          setState(() {
                            _isEditing = true;
                            _noteController.text = widget.events.first;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],

        if (_isEditing) ...[
          Gaps.hMd,
          Row(
            children: [
              Expanded(
                child: NotesTextField(
                  value: _noteController.text,
                  onChanged: (value) => _noteController.text = value,
                  onSubmit: () {
                    final text = _noteController.text.trim();
                    if (text.isNotEmpty) {
                      // Remove old note and add new one
                      widget.onRemoveEvent(widget.events.first);
                      widget.onAddEvent(text);
                      setState(() {
                        _isEditing = false;
                      });
                      _noteController.clear();
                    }
                  },
                  hintText: 'Edit your notes...',
                  maxLines: 4,
                ),
              ),
              Gaps.wSm,
              PrimaryButton(
                label: 'Save',
                onPressed: () {
                  final text = _noteController.text.trim();
                  if (text.isNotEmpty) {
                    // Remove old note and add new one
                    widget.onRemoveEvent(widget.events.first);
                    widget.onAddEvent(text);
                    setState(() {
                      _isEditing = false;
                    });
                    _noteController.clear();
                  }
                },
              ),
            ],
          ),
        ],
      ],
    );
  }
}
