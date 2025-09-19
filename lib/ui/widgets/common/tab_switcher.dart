// path: lib/ui/widgets/common/tab_switcher.dart
// Animated tab content swapper used by Match Details tabs.
import 'package:flutter/material.dart';

import 'package:FlutterApp/constants/app_durations.dart';

class TabSwitcher extends StatelessWidget {
  const TabSwitcher({
    required this.index,
    required this.children,
    super.key,
    this.duration = AppDurations.normal,
    this.curve = Curves.easeInOut,
    this.alignment = Alignment.topCenter,
    this.transitionBuilder,
  });

  final int index;
  final List<Widget> children;
  final Duration duration;
  final Curve curve;
  final AlignmentGeometry alignment;
  final AnimatedSwitcherTransitionBuilder? transitionBuilder;

  @override
  Widget build(BuildContext context) {
    assert(children.isNotEmpty, 'TabSwitcher requires at least one child.');
    final constrainedIndex = index.clamp(0, children.length - 1);
    final builder = transitionBuilder ?? _defaultTransition;

    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: curve,
      switchOutCurve: curve,
      layoutBuilder: (currentChild, previousChildren) => Stack(
        alignment: alignment,
        children: <Widget>[
          ...previousChildren,
          if (currentChild != null) currentChild,
        ],
      ),
      transitionBuilder: builder,
      child: KeyedSubtree(
        key: ValueKey<int>(constrainedIndex),
        child: children[constrainedIndex],
      ),
    );
  }

  Widget _defaultTransition(Widget child, Animation<double> animation) =>
      FadeTransition(opacity: animation, child: child);
}
