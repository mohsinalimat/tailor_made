import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rebloc/rebloc.dart';
import 'package:tailor_made/constants/mk_style.dart';
import 'package:tailor_made/dependencies.dart';
import 'package:tailor_made/providers/snack_bar_provider.dart';
import 'package:tailor_made/rebloc/app_state.dart';
import 'package:tailor_made/rebloc/measures/view_model.dart';
import 'package:tailor_made/screens/measures/_partials/measures_slide_block.dart';
import 'package:tailor_made/widgets/_partials/mk_app_bar.dart';
import 'package:tailor_made/widgets/_partials/mk_loading_spinner.dart';
import 'package:tailor_made/widgets/_views/empty_result_view.dart';

class MeasuresManagePage extends StatefulWidget {
  const MeasuresManagePage({super.key, required this.userId});

  final String userId;

  @override
  State<MeasuresManagePage> createState() => _MeasuresManagePageState();
}

class _MeasuresManagePageState extends State<MeasuresManagePage> with SnackBarProviderMixin {
  @override
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(
      const Duration(seconds: 2),
      () => showInSnackBar('Long-Press on any group to see more actions.'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      appBar: const MkAppBar(title: Text('Measurements')),
      body: _buildBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        backgroundColor: kAccentColor,
        foregroundColor: Colors.white,
        label: const Text('Add Group'),
        onPressed: () => Dependencies.di().measuresCoordinator.toCreateMeasures(widget.userId),
      ),
    );
  }

  Widget _buildBody() {
    return ViewModelSubscriber<AppState, MeasuresViewModel>(
      converter: MeasuresViewModel.new,
      builder: (_, __, MeasuresViewModel vm) {
        if (vm.isLoading) {
          return const Center(child: MkLoadingSpinner());
        }

        if (vm.model == null || vm.model!.isEmpty) {
          return const Center(child: EmptyResultView(message: 'No measurements available'));
        }

        return SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                for (int i = 0; i < vm.grouped!.length; i++)
                  MeasureSlideBlock(
                    title: vm.grouped!.keys.elementAt(i),
                    measures: vm.grouped!.values.elementAt(i),
                    userId: vm.userId,
                  ),
                const SizedBox(height: 72.0)
              ],
            ),
          ),
        );
      },
    );
  }
}
