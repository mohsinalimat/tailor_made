import 'package:flutter/material.dart';
import 'package:tailor_made/models/contact.dart';
import 'package:tailor_made/models/job.dart';
import 'package:tailor_made/models/payment.dart';
import 'package:tailor_made/screens/payments/_partials/payments_list.dart';
import 'package:tailor_made/widgets/_views/empty_result_view.dart';

class PaymentsListWidget extends StatelessWidget {
  const PaymentsListWidget({super.key, required this.contact, required this.jobs});

  final ContactModel? contact;
  final List<JobModel> jobs;

  @override
  Widget build(BuildContext context) {
    final List<PaymentModel> payments = jobs.fold<List<PaymentModel>>(
      <PaymentModel>[],
      (List<PaymentModel> acc, JobModel item) => acc..addAll(item.payments!),
    );

    if (payments.isEmpty) {
      return const SliverFillRemaining(child: EmptyResultView(message: 'No payments available'));
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      sliver: PaymentList(payments: payments.toList()),
    );
  }
}
