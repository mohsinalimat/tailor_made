import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rebloc/rebloc.dart';
import 'package:tailor_made/constants/mk_style.dart';
import 'package:tailor_made/models/contact.dart';
import 'package:tailor_made/rebloc/app_state.dart';
import 'package:tailor_made/rebloc/contacts/view_model.dart';
import 'package:tailor_made/screens/contacts/_partials/contact_appbar.dart';
import 'package:tailor_made/screens/contacts/_partials/contact_gallery_grid.dart';
import 'package:tailor_made/screens/contacts/_partials/contact_payments_list.dart';
import 'package:tailor_made/screens/jobs/_partials/jobs_list.dart';
import 'package:tailor_made/widgets/_partials/mk_loading_spinner.dart';
import 'package:tailor_made/widgets/theme_provider.dart';

const List<String> _tabs = <String>['Jobs', 'Gallery', 'Payments'];

class ContactPage extends StatelessWidget {
  const ContactPage({super.key, this.contact});

  final ContactModel? contact;

  @override
  Widget build(BuildContext context) {
    return ViewModelSubscriber<AppState, ContactsViewModel>(
      converter: (AppState state) => ContactsViewModel(state)..contactID = contact!.id,
      builder: (BuildContext context, DispatchFunction dispatch, ContactsViewModel viewModel) {
        // in the case of newly created contacts
        final ContactModel? contact = viewModel.selected ?? this.contact;
        return DefaultTabController(
          length: _tabs.length,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: kAccentColor,
              automaticallyImplyLeading: false,
              title: ContactAppBar(userId: viewModel.userId, contact: contact, grouped: viewModel.measuresGrouped),
              titleSpacing: 0.0,
              centerTitle: false,
              bottom: TabBar(
                labelStyle: ThemeProvider.of(context)!.body3Medium,
                tabs: _tabs.map((String tab) => Tab(child: Text(tab))).toList(),
              ),
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
            body: Builder(
              builder: (BuildContext context) {
                if (viewModel.isLoading) {
                  return const Center(child: MkLoadingSpinner());
                }

                return TabBarView(
                  children: <Widget>[
                    _TabView(
                      name: _tabs[0].toLowerCase(),
                      child: JobList(jobs: viewModel.selectedJobs),
                    ),
                    _TabView(
                      name: _tabs[1].toLowerCase(),
                      child: GalleryGridWidget(contact: contact, jobs: viewModel.selectedJobs),
                    ),
                    _TabView(
                      name: _tabs[2].toLowerCase(),
                      child: PaymentsListWidget(contact: contact, jobs: viewModel.selectedJobs),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _TabView extends StatelessWidget {
  const _TabView({required this.name, required this.child});

  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            key: PageStorageKey<String>(name),
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                sliver: child,
              ),
            ],
          );
        },
      ),
    );
  }
}
