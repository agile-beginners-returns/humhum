import 'dart:async';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:humhum/models/tests_mock.dart' as tests_mock;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jsonStateNotifierProvider =
    AsyncNotifierProvider<JsonStateNotifier, Map<String, dynamic>>(
  () => JsonStateNotifier(),
);

/// JSONデータを管理する非同期Notifer
class JsonStateNotifier extends AsyncNotifier<Map<String, dynamic>> {
  @override
  Future<Map<String, dynamic>> build() async {
    return {'Questions': null};
  }

  /// Dify APIを呼び出してデータを取得
  Future<Map<String, dynamic>?> callCloudFunctionsAPI(
      String userInputUrl) async {
    if (dotenv.get('Mock') == "true") {
      return tests_mock.mockData;
    }

    try {
      // Cloud Functionsインスタンスを取得
      final functions = FirebaseFunctions.instanceFor(region: 'us-central1');
      final callable = functions.httpsCallable('call-gemini-llm-function');

      // 呼び出し
      final result = await callable.call({
        'user_input': userInputUrl,
      });

      return result.data;
    } catch (e) {
      print("======TESTS API ERROR======");
      print(e);
      return {'Error': e.toString()};
    }
  }
}
