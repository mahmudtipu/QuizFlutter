import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xFFF1EFF1);
const kWhite = Color(0xFFFFFFFF);
const kPrimaryColor = Color(0xFF035AA6);
const kBlueColor = Color(0xFF0000FF);
const kpurpleColor = Color(0xFF720094);
const textBack = Color(0xFFED1E79);
const kTextColor = Color(0xFF000839);
const kTextLightColor = Color(0xFF747474);
const kTextBlueColor = Color(0xFF40BAD5);
const kYellowColor = Color(0xFFFBAE17);
const kShopListColor = Color(0xFF603813);

const kDefaultPadding = 20.0;

const kDefaultShadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12,
);

const kGreenColor = Color(0xFF6AC259);
const kRedColor = Color(0xFFFF0000);
const kGrayColor = Color(0xFF494949);
const kBlackColor = Color(0xFF101010);
const kPrimaryGradient = LinearGradient(
  colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

int energy = 0;
String backgroundImage = 'assets/images/energybar.png';

String setImage() {
  energy++;

  if(energy == 0) {
    backgroundImage = 'assets/images/energybar.png';
  }
  else if(energy == 1) {
    backgroundImage = 'assets/images/energyminusone.png';
  }
  else if(energy == 2) {
    backgroundImage = 'assets/images/energyminustwo.png';
  }
  else if(energy == 3) {
    backgroundImage = 'assets/images/energyminusthree.png';
  }
  else if(energy == 4) {
    backgroundImage = 'assets/images/energyminusfour.png';
  }
  else if(energy == 5)
    {
      backgroundImage = 'assets/images/zeroenergy.png';
    }
  return backgroundImage; // here it returns your _backgroundImage value
}

int c = 0;
int s = 0;
int coin = 0;
int money = 0;
int lives = 0;
String qu='';
int id = 0;
int ans = 0;
List<String> opt='' as List<String>;

String np = '';
String desc = '';
int prize = 0;
String time = '';
int thre = 0;
String pri = '';
String ter = '';