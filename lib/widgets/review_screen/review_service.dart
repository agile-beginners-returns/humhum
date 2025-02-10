// lib/services/review_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewService {
  static Future<List<Map<String, dynamic>>> fetchReviewQuestions(
      String userId, String reviewQuestionType) async {
    try {
      QuerySnapshot testResultsSnapshot = await FirebaseFirestore.instance
          .collection('test_results')
          .where('user_id', isEqualTo: userId)
          .get();

      List<Map<String, dynamic>> questions = [];

      for (QueryDocumentSnapshot resultDoc in testResultsSnapshot.docs) {
        QuerySnapshot testsSnapshot =
            await resultDoc.reference.collection('tests').get();

        for (QueryDocumentSnapshot testDoc in testsSnapshot.docs) {
          Map<String, dynamic> data = testDoc.data() as Map<String, dynamic>;
          if (data['questionType'] == reviewQuestionType &&
              data['answer'] != data['userAnswer']) {
            questions.add(data);
          }
        }
      }
      return questions;
    } catch (e) {
      print("Error fetching review questions: $e");
      return [];
    }
  }
}
