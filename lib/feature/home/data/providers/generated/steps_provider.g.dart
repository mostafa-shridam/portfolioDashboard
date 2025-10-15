// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../steps_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StepsProvider)
const stepsProviderProvider = StepsProviderProvider._();

final class StepsProviderProvider
    extends $NotifierProvider<StepsProvider, StepsState> {
  const StepsProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stepsProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stepsProviderHash();

  @$internal
  @override
  StepsProvider create() => StepsProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StepsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StepsState>(value),
    );
  }
}

String _$stepsProviderHash() => r'3867cafc1c8672a458b0fd6f97af358c51953a57';

abstract class _$StepsProvider extends $Notifier<StepsState> {
  StepsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<StepsState, StepsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StepsState, StepsState>,
              StepsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
