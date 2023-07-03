import 'package:flutter/material.dart';
import 'package:tailor_made/presentation/widgets.dart';

import '../../../utils.dart';

class JobsFilterButton extends StatelessWidget {
  const JobsFilterButton({super.key, required this.sortType, required this.onTapSort});

  final JobsSortType sortType;
  final ValueSetter<JobsSortType> onTapSort;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle optionTheme = theme.textTheme.bodyMedium!;
    final ColorScheme colorScheme = theme.colorScheme;
    return SizedBox.fromSize(
      size: const Size.square(48.0),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: PopupMenuButton<JobsSortType>(
              icon: const Icon(Icons.filter_list),
              onSelected: onTapSort,
              itemBuilder: (BuildContext context) {
                return <_Option>[
                  _Option(
                    text: 'Sort by Active',
                    type: JobsSortType.active,
                    enabled: sortType != JobsSortType.active,
                    style: optionTheme.copyWith(color: _colorTestFn(JobsSortType.active, colorScheme)),
                  ),
                  _Option(
                    text: 'Sort by Name',
                    type: JobsSortType.names,
                    enabled: sortType != JobsSortType.names,
                    style: optionTheme.copyWith(color: _colorTestFn(JobsSortType.names, colorScheme)),
                  ),
                  _Option(
                    text: 'Sort by Owed',
                    type: JobsSortType.owed,
                    enabled: sortType != JobsSortType.owed,
                    style: optionTheme.copyWith(color: _colorTestFn(JobsSortType.owed, colorScheme)),
                  ),
                  _Option(
                    text: 'Sort by Payments',
                    type: JobsSortType.payments,
                    enabled: sortType != JobsSortType.payments,
                    style: optionTheme.copyWith(color: _colorTestFn(JobsSortType.payments, colorScheme)),
                  ),
                  _Option(
                    text: 'Sort by Price',
                    type: JobsSortType.price,
                    enabled: sortType != JobsSortType.price,
                    style: optionTheme.copyWith(color: _colorTestFn(JobsSortType.price, colorScheme)),
                  ),
                  _Option(
                    text: 'Sort by Recent',
                    type: JobsSortType.recent,
                    enabled: sortType != JobsSortType.recent,
                    style: optionTheme.copyWith(color: _colorTestFn(JobsSortType.recent, colorScheme)),
                  ),
                  _Option(
                    text: 'No Sort',
                    type: JobsSortType.reset,
                    enabled: sortType != JobsSortType.reset,
                    style: optionTheme.copyWith(color: _colorTestFn(JobsSortType.reset, colorScheme)),
                  ),
                ];
              },
            ),
          ),
          Align(
            alignment: const Alignment(0.75, -0.5),
            child: sortType != JobsSortType.reset ? Dots(color: colorScheme.secondary) : null,
          ),
        ],
      ),
    );
  }

  Color? _colorTestFn(JobsSortType type, ColorScheme colorScheme) => sortType == type ? colorScheme.secondary : null;
}

class _Option extends PopupMenuItem<JobsSortType> {
  _Option({
    required super.enabled,
    required this.text,
    required this.type,
    required this.style,
  }) : super(
          value: type,
          child: Text(text, style: style),
        );

  final String text;
  final JobsSortType type;
  final TextStyle style;
}