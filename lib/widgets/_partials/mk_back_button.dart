import 'package:flutter/material.dart';
import 'package:tailor_made/utils/mk_theme.dart';
import 'package:tailor_made/widgets/_partials/mk_clear_button.dart';

class MkBackButton extends StatelessWidget {
  const MkBackButton({
    Key key,
    this.color,
    this.onPop,
  }) : super(key: key);

  final Color color;
  final VoidCallback onPop;

  @override
  Widget build(BuildContext context) {
    return MkClearButton(
      child: Icon(
        Icons.arrow_back_ios,
        color: color ?? MkTheme.of(context).appBarTitle.color,
        size: 18.0,
      ),
      onPressed: onPop ?? () => Navigator.maybePop(context),
    );
  }
}
