import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tailor_made/presentation/theme.dart';

class AccessDeniedPage extends StatelessWidget {
  const AccessDeniedPage({super.key, required this.onSendMail});

  final VoidCallback onSendMail;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle textTheme = theme.textTheme.bodyLarge!;
    final ColorScheme colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SpinKitFadingCube(color: colorScheme.outlineVariant),
          const SizedBox(height: 48.0),
          Text(
            'ACCESS DENIED',
            style: textTheme.copyWith(color: Colors.black87, fontWeight: AppFontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64.0),
            child: Text(
              'Do not be alarmed. \n We just need your attention. \n\n It is possible you have violated one or a couple of our usage policy?.\n If this is not the case, please contact an Administrator.',
              style: textTheme.copyWith(color: colorScheme.outline),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32.0),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.secondary,
              shape: const StadiumBorder(),
            ),
            onPressed: onSendMail,
            icon: const Icon(Icons.mail),
            label: const Text('Send a mail'),
          ),
        ],
      ),
    );
  }
}