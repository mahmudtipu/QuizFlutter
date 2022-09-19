import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiznp/firebase.dart';
import 'package:quiznp/screens/home/dailyplay/components/ad_helper.dart';
import 'package:quiznp/screens/home/dailyplay/model/questions.dart';
import 'package:quiznp/screens/home/dailyplay/rewardanimi/rewards.dart';

import '../../../../constants.dart';

// We use get package for our state management

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  // Lets animated our progress bar

  late AnimationController _animationController;
  late Animation _animation;

  // so that we can access our animation outside
  Animation get animation => this._animation;

  late PageController _pageController;

  PageController get pageController => this._pageController;

  List<Question> _questions = [];

  List<Question> get questions => this._questions;

  bool _isAnswered = false;

  bool get isAnswered => this._isAnswered;

  late int _correctAns;

  int get correctAns => this._correctAns;

  late int _selectedAns;

  int get selectedAns => this._selectedAns;

  // for more about obs please check documentation
  RxInt _questionNumber = 1.obs;

  RxInt get questionNumber => this._questionNumber;

  RxInt _coin = c.obs;

  RxInt get coin => this._coin;

  RxInt _sticker = s.obs;

  RxInt get sticker => this._sticker;

  int _numOfCorrectAns = 0;

  int get numOfCorrectAns => this._numOfCorrectAns;
  bool _isRewardedAdReady = false;

  RewardedAd? _rewardedAd;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    quest(_questions);
    _loadRewardedAd();
    // Our animation duration is 60 s
    // so our plan is to fill the progress bar within 60s
    _animationController =
        AnimationController(duration: Duration(seconds: 30), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        // update like setState
        update();
      });

    // start our animation
    // Once 60s is completed go to the next qn
    //_animationController.forward().whenComplete(nextQuestion);
    _animationController.forward();
    _pageController = PageController();
    super.onInit();
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
        this._rewardedAd = ad;
        ad.fullScreenContentCallback =
            FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
              _isRewardedAdReady = false;
              _loadRewardedAd();
            });
        _isRewardedAdReady = true;
      }, onAdFailedToLoad: (error) {
        print('Failed to load a rewarded ad: ${error.message}');
        _isRewardedAdReady = false;
      }),
    );
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(Question question, int selectedIndex) {

    // because once user press any option then it will run
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns != _selectedAns) {
      s++;
      if (_isRewardedAdReady)
        _rewardedAd?.show(
          onUserEarnedReward: (_, reward) {
            // QuizManager.instance.useHint();
          },
        );
    } else {
      if(s==0)
        {
          c++;
          _coin.value = c;
        }
      // Once user select an ans after 3s it will go to the next qn
      Future.delayed(Duration(seconds: 3), () {
        nextQuestion();
      });
    }

    // It will stop the counter
    _animationController.stop();
    update();
  }

  void nextQuestion() {
    s=0;
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      _animationController.reset();

      // Then start it again
      // Once timer is finish go to the next qn
      //_animationController.forward().whenComplete(nextQuestion);
      _animationController.forward();
    } else {
      // Get package provide us simple way to naviigate another page
      Get.dialog(
        Center(
          child: Material(
            color: Colors.blueGrey,
            child: WillPopScope(
              onWillPop: () async => false,
              child: Container(
                  height: 270,
                  width: 320,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/medal.png',
                        width: 110,
                        height: 110,
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/images/coinn.png',
                            ),
                          ),
                          Text(
                            '$c',
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      //Image.asset('assets/images/happy.png', scale: 1.5),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          _animationController.reset();
                          //_animationController.forward();
                          _questionNumber = 1.obs;
                          _isAnswered = false;
                          Get.back();
                          Get.back();
                          Get.to(RewardScreen());
                        },
                        child: Padding(
                          padding:
                          const EdgeInsets.only(top: 5.0, bottom: 20),
                          child: Container(
                            height: 40,
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: Center(
                              child: Text(
                                "Collect coins",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),),
            ),
          ),
        ),
        barrierDismissible: false,
      );
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

  Future<void> quest(List data) async {

    FirebaseFirestore.instance.collection("question").get().then(
          (QuerySnapshot snapshot) =>
          snapshot.docs.forEach((f) {
            data.add(Question(id: f['id'], question: f['question'], answer: f['answer_index'], options: List.from(f['options'])));

          /*  _questions=data
                .map(
                  (question) => Question(
                  id: question['id'],
                  question: question['question'],
                  options: question['options'],
                  answer: question['answer_index']),
            )
                .toList(); */
            //data.add(Question(id: f['id'], question: f['question'], answer: f['answer_index'], options: List.from(f['options'])));
          }),
    );
   // _questions =
  }
}
