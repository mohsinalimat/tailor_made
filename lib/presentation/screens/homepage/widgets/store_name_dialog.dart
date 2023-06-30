import 'package:flutter/material.dart';
import 'package:tailor_made/domain.dart';
import 'package:tailor_made/presentation/theme.dart';
import 'package:tailor_made/presentation/widgets.dart';

class StoreNameDialog extends StatelessWidget {
  const StoreNameDialog({super.key, required this.account});

  final AccountEntity account;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: const AppCloseButton(color: Colors.white),
      ),
      backgroundColor: Colors.black38,
      body: _Content(account: account),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content({required this.account});

  final AccountEntity account;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  late final TextEditingController _controller = TextEditingController(text: widget.account.storeName);

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 48.0),
              const Center(
                child: CircleAvatar(
                  backgroundColor: kAccentColor,
                  foregroundColor: Colors.white,
                  radius: 36.0,
                  child: Icon(Icons.store, size: 50.0),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Store Name',
                style: ThemeProvider.of(context).title.copyWith(color: Colors.black38),
              ),
              const SizedBox(height: 64.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _controller,
                  textAlign: TextAlign.center,
                  style: ThemeProvider.of(context).title,
                  onSubmitted: (String value) => _handleSubmit(context),
                  decoration: const InputDecoration(isDense: true, hintText: 'Enter Store Name'),
                ),
              ),
              const SizedBox(height: 64.0),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmit(BuildContext context) {
    final String value = _controller.text.trim();
    if (value.isEmpty) {
      return;
    }
    Navigator.pop(context, value);
  }
}
