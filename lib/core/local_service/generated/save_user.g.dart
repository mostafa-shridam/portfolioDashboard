// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../save_user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveUser)
const saveUserProvider = SaveUserProvider._();

final class SaveUserProvider
    extends $FunctionalProvider<SaveUser, SaveUser, SaveUser>
    with $Provider<SaveUser> {
  const SaveUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveUserHash();

  @$internal
  @override
  $ProviderElement<SaveUser> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SaveUser create(Ref ref) {
    return saveUser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveUser value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveUser>(value),
    );
  }
}

String _$saveUserHash() => r'47d14b599808825244502afea09b9bf188237e5d';
