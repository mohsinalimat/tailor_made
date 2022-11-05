import 'package:flutter/material.dart';
import 'package:tailor_made/constants/mk_strings.dart';
import 'package:tailor_made/constants/mk_style.dart';
import 'package:tailor_made/dependencies.dart';
import 'package:tailor_made/models/job.dart';
import 'package:tailor_made/utils/mk_money.dart';
import 'package:tailor_made/widgets/theme_provider.dart';

class JobListItem extends StatelessWidget {
  const JobListItem({super.key, required this.job});

  final JobModel job;

  @override
  Widget build(BuildContext context) {
    final DateTime date = job.createdAt!;
    final String price = MkMoney(job.price).formatted;
    final String paid = MkMoney(job.completedPayment).formatted;
    final String owed = MkMoney(job.pendingPayment).formatted;
    final ThemeProvider theme = ThemeProvider.of(context)!;

    return Material(
      child: InkWell(
        onTap: () => Dependencies.di().jobsCoordinator.toJob(job),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '${date.day}\n', style: theme.display1),
                      TextSpan(
                        text: MkStrings.monthsShort[date.month - 1].toUpperCase(),
                        style: theme.small.copyWith(letterSpacing: 2.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(job.name!, style: theme.subhead3Semi),
                    const SizedBox(height: 2.0),
                    Text(price, style: theme.body1),
                    const SizedBox(height: 2.0),
                    if (job.pendingPayment! > 0)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.arrow_drop_up, color: Colors.green.shade600, size: 12.0),
                          const SizedBox(width: 2.0),
                          Text(paid, style: const TextStyle(fontSize: 11.0)),
                          const SizedBox(width: 4.0),
                          Icon(Icons.arrow_drop_down, color: Colors.red.shade600, size: 12.0),
                          const SizedBox(width: 2.0),
                          Text(owed, style: const TextStyle(fontSize: 11.0)),
                        ],
                      )
                    else
                      Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: Colors.green.shade600,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Icon(Icons.attach_money, size: 12.0, color: Colors.white),
                      ),
                  ],
                ),
              ),
              Icon(Icons.check, color: job.isComplete! ? kPrimaryColor : kTextBaseColor),
            ],
          ),
        ),
      ),
    );
  }
}
