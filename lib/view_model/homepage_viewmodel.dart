import 'dart:async';
import 'package:eduasses360/View/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:page_transition/page_transition.dart';
import '../View/home_page/home_page.dart';
import '../model/question_model.dart';
import '../services/api_services.dart';
import '../services/firebase_services/firebase_services.dart';
import 'package:flutter/material.dart';

import '../utils/routes/route_name.dart';
import '../utils/utils.dart';

class HomePageViewModel with ChangeNotifier {

  //public question api
  static const String url = "https://the-trivia-api.com/v2/questions/";

  final List<QuestionModel> questionList = [];

  //get public api data
  Future getApiData() async {
    questionList.clear();
    var data = await ApiServices().getApiData(url);

    for (Map<String, dynamic> i in data) {
      questionList.add(
        QuestionModel.fromJson(i),
      );
    }

    if (kDebugMode) {
      print("List added successfully");
    }

    Timer(const Duration(seconds: 100), () {
      notifyListeners();
    });
    return questionList;
  }

  //make mcq answer shuffled
  List<String> getShuffledAnswer(QuestionModel question) {
    final List<String> answerList = [];
    if (question.incorrectAnswers != null && question.correctAnswer != null) {
      answerList.addAll(question.incorrectAnswers!);
      answerList.add(question.correctAnswer!);
    }
    answerList.shuffle();
    return answerList;
  }


}
