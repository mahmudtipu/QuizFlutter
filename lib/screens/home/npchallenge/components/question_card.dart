import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiznp/screens/home/npchallenge/components/option.dart';
import 'package:quiznp/screens/home/npchallenge/controller/question_controller.dart';
import 'package:quiznp/screens/home/npchallenge/model/questions.dart';

import '../../../../constants.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    // it means we have to pass this
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    NPQuestionController _controller = Get.put(NPQuestionController());
    return Card(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [kpurpleColor, Colors.purpleAccent])
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    question.question,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: kWhite),
                  ),
                ),
              ),
            ),
            ...List.generate(
              question.options.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Option(
                index: index,
                text: question.options[index],
                press: () => _controller.checkAns(question, index),
              ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}