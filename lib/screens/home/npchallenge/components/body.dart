import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiznp/screens/home/dailyplay/components/ad_helper.dart';
import 'package:quiznp/screens/home/npchallenge/controller/question_controller.dart';
import 'package:quiznp/screens/home/home.dart';

import '../../../../constants.dart';
import 'progress_bar.dart';
import 'question_card.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);
  @override
  State<Body> createState() => _BodyScreenState();
}

class _BodyScreenState extends State<Body> {
  bool _isRewardedAdReady = false;

  RewardedAd? _rewardedAd;

  //String _backgroundImage = 'assets/images/energybar.png';

  @override
  void initState() {
    super.initState();

    _loadRewardedAd();
    if (_isRewardedAdReady)
      _rewardedAd?.show(
        onUserEarnedReward: (_, reward) {
          // QuizManager.instance.useHint();
        },
      );
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
        this._rewardedAd = ad;
        ad.fullScreenContentCallback =
            FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
              setState(() {
                _isRewardedAdReady = false;
              });
              _loadRewardedAd();
            });
        setState(() {
          _isRewardedAdReady = true;
        });
      }, onAdFailedToLoad: (error) {
        print('Failed to load a rewarded ad: ${error.message}');
        setState(() {
          _isRewardedAdReady = false;
        });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {

    Future<bool?> _openMyPage() async {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Exit without finishing?'),
              //content: Text('Please press the SAVE button at the bottom of the page'),
              actions: <Widget>[
                TextButton(
                  child: Text('NO'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: Text('YES'),
                  onPressed: () {
                    Get.back();
                    Get.back();
                    c=0;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Home();
                          },
                        )
                    );
                    /*if (_isRewardedAdReady)
                      _rewardedAd?.show(
                        onUserEarnedReward: (_, reward) {
                          // QuizManager.instance.useHint();
                        },
                      );*/
                  },
                ),
              ],
            );
          });
    }
    // So that we have acccess our controller
    NPQuestionController _questionController = Get.put(NPQuestionController());
    return WillPopScope(
      onWillPop: () async {
        bool? result= await _openMyPage();
        if(result == null){
          result = false;
        }
        return result;
      },
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(50),
                        child: Center(
                          child: Text(
                            'NP Challenge',
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                fontSize: 25.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20),
                            child: Obx(
                                  () => Text.rich(
                                TextSpan(
                                  text:
                                  "Question # ${_questionController.questionNumber.value}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: "/${_questionController.questions.length}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20),
                            child: ProgressBar(),
                          ),
                        ],
                      ),
                      Divider(thickness: 1.5),
                      SizedBox(height: 20),
                      Container(
                        height: 400,
                        child: PageView.builder(
                          // Block swipe to next qn
                          physics: NeverScrollableScrollPhysics(),
                          controller: _questionController.pageController,
                          onPageChanged: _questionController.updateTheQnNum,
                          itemCount: _questionController.questions.length,
                          itemBuilder: (context, index) => QuestionCard(
                              question: _questionController.questions[index]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 30),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    'assets/images/dollar.png',
                                  ),
                                ),
                                Obx(
                                      () => Text(
                                        "${_questionController.dollar.value}",
                                        textAlign: TextAlign.center,
                                        style: new TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black54,
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}