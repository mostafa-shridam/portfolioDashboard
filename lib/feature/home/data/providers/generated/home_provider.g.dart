// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeProvider)
const homeProviderProvider = HomeProviderProvider._();

final class HomeProviderProvider
    extends $NotifierProvider<HomeProvider, HomeState> {
  const HomeProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeProviderHash();

  @$internal
  @override
  HomeProvider create() => HomeProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeState>(value),
    );
  }
}

String _$homeProviderHash() => r'43978f5ed9af69bb11aa8d098eed9c70629d409b';

abstract class _$HomeProvider extends $Notifier<HomeState> {
  HomeState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<HomeState, HomeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HomeState, HomeState>,
              HomeState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
