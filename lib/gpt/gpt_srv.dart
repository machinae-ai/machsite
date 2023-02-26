import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GptSrv {
  static String? key;
  static final openAI = OpenAI.instance.build(
    token: key,
    baseOption: HttpSetup(receiveTimeout: 6000),
    isLogger: true,
  );

  static Init(String k) {
    key = k;
  }

  static Future<CTResponse?> prompt(
    String prompt,
    String roomId,
  ) async {
    final request = CompleteText(
      prompt: prompt,
      model: kTranslateModelV3,
    );
    return await openAI.onCompleteText(request: request);
  }
}
