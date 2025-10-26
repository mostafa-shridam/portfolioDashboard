// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../about_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AboutProvider)
const aboutProviderProvider = AboutProviderProvider._();

final class AboutProviderProvider
    extends $NotifierProvider<AboutProvider, AboutState> {
  const AboutProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aboutProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aboutProviderHash();

  @$internal
  @override
  AboutProvider create() => AboutProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AboutState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AboutState>(value),
    );
  }
}

String _$aboutProviderHash() => r'e0a4d9c3a78e15b51926ccb28092412a833205b2';

abstract class _$AboutProvider extends $Notifier<AboutState> {
  AboutState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AboutState, AboutState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AboutState, AboutState>,
              AboutState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
