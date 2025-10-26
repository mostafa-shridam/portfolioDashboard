import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants.dart';
part 'generated/supabase_service.g.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  SupabaseService._internal();
  static SupabaseService get instance => _instance;

  final SupabaseClient _supabase = Supabase.instance.client;

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  bool get getIsLoading => isLoading.value;
  static Future<void> initSupabase() async {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAPIKey);
  }

  void _setLoading(bool value) {
    isLoading.value = value;
    log('[SupabaseService] Supabase Loading = $value');
  }

  Future<bool> _checkBucketExists(String name) async {
    try {
      _setLoading(true);
      final buckets = await _supabase.storage.listBuckets();
      _setLoading(false);
      return buckets.any((bucket) => bucket.name == name);
    } catch (e) {
      log('Error checking bucket existence: $e', name: 'SupabaseService');
      _setLoading(false);
      return false;
    }
  }

  final String bucketName = 'images';

  Future<void> _createBucketIfNeeded({String? name}) async {
    if (!await _checkBucketExists(name ?? bucketName)) {
      await _supabase.storage.createBucket(name ?? bucketName);
    }
  }

  Future<String?> uploadImage({
    required Uint8List file,
    String originalFileName = 'image.png',
    String? bucket,
  }) async {
    try {
      _setLoading(true);
      await _createBucketIfNeeded(name: bucket ?? bucketName);

      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_$originalFileName';

      await _supabase.storage
          .from(bucket ?? bucketName)
          .uploadBinary(fileName, file);

      final publicUrl = _supabase.storage
          .from(bucket ?? bucketName)
          .getPublicUrl(fileName);

      log('[SupabaseService] ✅ Image uploaded successfully: $publicUrl');
      return publicUrl;
    } catch (e) {
      log('Error uploading image: $e');
      return null;
    } finally {
      _setLoading(false);
    }
  }
}

@riverpod
SupabaseService supabaseService(Ref ref) => SupabaseService.instance;
