import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userportfolio/feature/home/data/providers/steps_provider.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/theme/style.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../settings/presentation/settings_page.dart';

class HomeMobile extends ConsumerWidget {
  const HomeMobile({super.key, required this.userData});
  final UserModel userData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final steps = ref.watch(stepsProviderProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.pushNamed(context, SettingsPage.routeName);
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                children: List.generate(
                  5,
                  (index) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 4,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Color(
                            index ==
                                    ref
                                        .read(stepsProviderProvider.notifier)
                                        .getTotalSteps()
                                ? greenColor.toARGB32()
                                : ref
                                      .read(stepsProviderProvider.notifier)
                                      .getStepColor(index),
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            (index + 1).toString(),
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      Text(
                        ref
                            .read(stepsProviderProvider.notifier)
                            .getStepLabel(index),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),

              CustomButton(
                text: 'التالي',
                onPressed: () {
                  ref
                      .read(stepsProviderProvider.notifier)
                      .updateSteps(steps.currentStep ?? 0 + 1);
                },
              ),
              // StepsProgress(
              //   currentStep: 2,
              //   totalSteps: 5,
              //   showNumbers: true,
              //   showLabels: true,
              //   labels: ['التسجيل', 'البيانات', 'التحقق', 'المراجعة', 'الانتهاء'],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
