// path: lib/ui/widgets/journal/journal_notes_section.dart
// Notes section component for prediction journal.
// FIXES: remove Expanded inside scrollable (caused unbounded height error),
// use vertical layout with proper paddings and full-width buttons.

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
          // Add note section (vertical, no Expanded to avoid unbounded height)
          NotesTextField(
            value: _noteController.text,
            onChanged: (value) => _noteController.text = value,
            onSubmit: _submitAdd,
            hintText: 'Add your notes for this day...',
            maxLines: 4,
          ),
          Gaps.hMd,
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: 'Add Note',
              onPressed: _submitAdd,
            ),
          ),
        ] else ...[
          // Display notes section
          Container(
            padding: Insets.allMd,
            decoration: const BoxDecoration(
              color: AppColors.cardDark,
              borderRadius: AppRadius.cardLg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.events.last,
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
                          widget.onRemoveEvent(widget.events.last);
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
                            _noteController.text = widget.events.last;
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

        // Edit form (vertical, no Expanded)
        if (_isEditing) ...[
          Gaps.hMd,
          NotesTextField(
            value: _noteController.text,
            onChanged: (value) => _noteController.text = value,
            onSubmit: _submitEdit,
            hintText: 'Edit your notes...',
            maxLines: 4,
          ),
          Gaps.hSm,
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: 'Save',
                  onPressed: _submitEdit,
                ),
              ),
              Gaps.wSm,
              Expanded(
                child: SecondaryGreenButtonLight(
                  label: 'Cancel',
                  onPressed: () {
                    setState(() => _isEditing = false);
                    _noteController.clear();
                  },
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  void _submitAdd() {
    final text = _noteController.text.trim();
    if (text.isEmpty) return;
    widget.onAddEvent(text);
    _noteController.clear();
  }

  void _submitEdit() {
    final text = _noteController.text.trim();
    if (text.isEmpty) return;
    // Replace all existing notes with new one
    widget.events.forEach(widget.onRemoveEvent);
    widget.onAddEvent(text);
    setState(() => _isEditing = false);
    _noteController.clear();
  }
}
