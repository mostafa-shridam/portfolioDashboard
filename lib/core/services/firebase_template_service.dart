import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/draggable_element_model.dart';

class FirebaseTemplateService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // حفظ موضع عنصر واحد
  static Future<void> saveElementPosition({
    required String userId,
    required String templateId,
    required DraggableElementModel element,
  }) async {
    try {
      await _firestore
          .collection('user_templates')
          .doc(userId)
          .collection('templates')
          .doc(templateId)
          .collection('elements')
          .doc(element.id)
          .set(element.toJson());
    } catch (e) {
      print('Error saving element position: $e');
    }
  }

  // حفظ مواضع عدة عناصر دفعة واحدة
  static Future<void> saveMultipleElements({
    required String userId,
    required String templateId,
    required List<DraggableElementModel> elements,
  }) async {
    try {
      final batch = _firestore.batch();

      for (final element in elements) {
        final docRef = _firestore
            .collection('user_templates')
            .doc(userId)
            .collection('templates')
            .doc(templateId)
            .collection('elements')
            .doc(element.id);

        batch.set(docRef, element.toJson());
      }

      await batch.commit();
    } catch (e) {
      print('Error saving multiple elements: $e');
    }
  }

  // استرجاع مواضع العناصر
  static Future<List<DraggableElementModel>> getTemplateElements({
    required String userId,
    required String templateId,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('user_templates')
          .doc(userId)
          .collection('templates')
          .doc(templateId)
          .collection('elements')
          .get();

      return snapshot.docs
          .map((doc) => DraggableElementModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error getting template elements: $e');
      return [];
    }
  }

  // استرجاع مواضع العناصر في الوقت الفعلي
  static Stream<List<DraggableElementModel>> getTemplateElementsStream({
    required String userId,
    required String templateId,
  }) {
    return _firestore
        .collection('user_templates')
        .doc(userId)
        .collection('templates')
        .doc(templateId)
        .collection('elements')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => DraggableElementModel.fromJson(doc.data()))
              .toList(),
        );
  }

  // حذف عنصر
  static Future<void> deleteElement({
    required String userId,
    required String templateId,
    required String elementId,
  }) async {
    try {
      await _firestore
          .collection('user_templates')
          .doc(userId)
          .collection('templates')
          .doc(templateId)
          .collection('elements')
          .doc(elementId)
          .delete();
    } catch (e) {
      print('Error deleting element: $e');
    }
  }

  // حفظ إعدادات التمبليت العامة
  static Future<void> saveTemplateSettings({
    required String userId,
    required String templateId,
    required Map<String, dynamic> settings,
  }) async {
    try {
      await _firestore
          .collection('user_templates')
          .doc(userId)
          .collection('templates')
          .doc(templateId)
          .set({
            'settings': settings,
            'lastModified': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
    } catch (e) {
      print('Error saving template settings: $e');
    }
  }
}
