import 'badges.dart';

/// Utility class. Don't try to use it!
///
/// This contain a custom position for the [Badge]
class BadgePosition {
  /// This is the distance to the top side of a parent widget.
  final double? top;

  /// This is the distance to the end side of a parent widget.
  final double? end;

  /// This is the distance to the start side of a parent widget.
  final double? start;

  /// This is the distance to the bottom side of a parent widget.
  final double? bottom;

  /// This is indicate that centralise is required
  final bool isCenter;

  /// This creates a new instance of this widget
  const BadgePosition({
    this.top,
    this.end,
    this.bottom,
    this.start,
    this.isCenter = false,
  });

  /// Factory method that creates a new instance of this widget
  /// according to the center
  factory BadgePosition.center() {
    return const BadgePosition(isCenter: true);
  }

  /// Factory method that creates a new instance of this widget
  /// according to [top] and [start]
  factory BadgePosition.topStart({double top = -5, double start = -10}) {
    return BadgePosition(top: top, start: start);
  }

  /// Factory method that creates a new instance of this widget
  /// according to [top] and [end]
  factory BadgePosition.topEnd({double top = -8, double end = -10}) {
    return BadgePosition(top: top, end: end);
  }

  /// Factory method that creates a new instance of this widget
  /// according to [bottom] and [end]
  factory BadgePosition.bottomEnd({double bottom = -8, double end = -10}) {
    return BadgePosition(bottom: bottom, end: end);
  }

  /// Factory method that creates a new instance of this widget
  /// according to [bottom] and [start]
  factory BadgePosition.bottomStart({double bottom = -8, double start = -10}) {
    return BadgePosition(bottom: bottom, start: start);
  }
}
