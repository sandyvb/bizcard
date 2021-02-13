import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'controller.dart';

final Controller c = Get.find();

// DECORATE UPDATE SCREEN TEXT INPUTS
InputDecoration getInputDecoration({String value}) {
  String hintText;
  String defaultText;
  IconData icon;
  String cVariable;

  if (value == 'myFirstName') {
    defaultText = 'Enter Your First Name';
    icon = Icons.person;
    cVariable = c.myFirstName.value;
  } else if (value == 'myLastName') {
    defaultText = 'Enter Your Last Name';
    icon = Icons.person;
    cVariable = c.myLastName.value;
  } else if (value == 'myTitle') {
    defaultText = 'Enter Your Title';
    icon = MaterialCommunityIcons.format_title;
    cVariable = c.myTitle.value;
  } else if (value == 'myPhone') {
    defaultText = 'Enter Your Phone Number';
    icon = Icons.phone;
    cVariable = c.myPhone.value;
  } else if (value == 'myEmail') {
    defaultText = 'Enter Your Email Address';
    icon = Icons.email;
    cVariable = c.myEmail.value;
  } else if (value == 'myWebsite') {
    defaultText = 'Optional Website URL';
    icon = Icons.web;
    cVariable = c.myWebsite.value;
  } else if (value == 'myLinkedIn') {
    defaultText = 'Optional LinkedIn URL';
    icon = Ionicons.logo_linkedin;
    cVariable = c.myLinkedIn.value;
  } else if (value == 'myLink') {
    defaultText = 'Optional Additional Link';
    icon = Icons.link;
    cVariable = c.myLink.value;
  } else if (value == 'myGreeting') {
    defaultText = 'Enter a Greeting';
    icon = MaterialCommunityIcons.human_greeting;
    cVariable = c.myGreeting.value;
  } else {
    defaultText = 'Enter a Closing Salutation';
    icon = MaterialCommunityIcons.message_text_outline;
    cVariable = c.myMessage.value;
  }

  hintText = c.fileContent[value] != null && c.fileContent[value].length > 0 ? cVariable : defaultText;

  return InputDecoration(
    labelStyle: TextStyle(color: Color(c.backgroundColor.value), fontWeight: FontWeight.bold),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(c.buttonColor.value)),
    ),
    fillColor: Color(c.cardColor.value),
    hintText: hintText,
    prefixIcon: Icon(icon, color: Color(c.iconColor.value)),
  );
}

// COLOR SCHEME - DISPLAY COLOR BOX
Container colorContainer({Color color}) {
  return Container(
    width: 22,
    height: 22,
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.white38,
      ),
    ),
    child: Container(color: color),
  );
}

// UPDATE VALUES TO CHANGE COLOR SCHEME
void changeColors(String theme) {
  if (theme == 'teal') {
    c.backgroundColor.value = 0xFF008080;
    c.buttonColor.value = 0xFFF6F6D1;
    c.errorColor.value = 0xFFFFFF00;
    c.appbarColor.value = 0xFFF6F6D1;
    c.cardColor.value = 0xFFFFFFFF;
    c.dividerColor.value = 0xFFB2DFDB;
    c.iconColor.value = 0xFF008080;
    c.myNameColor.value = 0xFFFFFFFF;
    c.headingTextColor.value = 0xFFB2DFDB;
    c.myInfoColor.value = 0xFF008080;
    c.inputLabelColor.value = 0xFF008080;
    c.appbarTextColor.value = 0xFF008080;
  } else if (theme == 'black') {
    c.backgroundColor.value = 0xFF0B0909;
    c.buttonColor.value = 0xFF44444C;
    c.errorColor.value = 0xFFC3073F;
    c.appbarColor.value = 0xFF44444C; //buttonColor
    c.cardColor.value = 0xFFD6D6D6;
    c.dividerColor.value = 0xFF8C8C8C;
    c.iconColor.value = 0xFF44444C; //buttonColor
    c.myNameColor.value = 0xFFD6D6D6; //cardColor
    c.headingTextColor.value = 0xFFD6D6D6; //cardColor
    c.myInfoColor.value = 0xFF44444C; //buttonColor
    c.inputLabelColor.value = 0xFF44444C; //buttonColor
    c.appbarTextColor.value = 0xFFD6D6D6; //cardColor
  } else if (theme == 'deepBlue') {
    c.backgroundColor.value = 0xFF0C0032;
    c.buttonColor.value = 0xFF3500d3;
    c.errorColor.value = 0xFFFFFF00;
    c.appbarColor.value = 0xFF3500d3; //buttonColor
    c.cardColor.value = 0xFFFFFFFF;
    c.dividerColor.value = 0xFF4B7BF5;
    c.iconColor.value = 0xFF3500d3; //buttonColor
    c.myNameColor.value = 0xFFFFFFFF; //cardColor
    c.headingTextColor.value = 0xFFFFFFFF; //cardColor
    c.myInfoColor.value = 0xFF3500d3; //buttonColor
    c.inputLabelColor.value = 0xFF3500d3; //buttonColor
    c.appbarTextColor.value = 0xFFFFFFFF; //cardColor
  } else if (theme == 'pastel') {
    c.backgroundColor.value = 0xFF999DA0;
    c.buttonColor.value = 0xFFF09CA2;
    c.errorColor.value = 0xFF603F8B;
    c.appbarColor.value = 0xFFF09CA2; //buttonColor
    c.cardColor.value = 0xFFF3F3E7;
    c.dividerColor.value = 0xFFB2C4CB;
    c.iconColor.value = 0xFFF09CA2; //buttonColor
    c.myNameColor.value = 0xFFF3F3E7; //cardColor
    c.headingTextColor.value = 0xFFF3F3E7; //cardColor
    c.myInfoColor.value = 0xFFF09CA2; //buttonColor
    c.inputLabelColor.value = 0xFFF09CA2; //buttonColor
    c.appbarTextColor.value = 0xFFF3F3E7; //cardColor
  } else if (theme == 'earthy') {
    c.backgroundColor.value = 0xFFC6CDC1;
    c.buttonColor.value = 0xFF63A15F;
    c.errorColor.value = 0xFFE7717D;
    c.appbarColor.value = 0xFF63A15F; //buttonColor
    c.cardColor.value = 0xFFF5F6F0;
    c.dividerColor.value = 0xFF63A15F;
    c.iconColor.value = 0xFF63A15F; //buttonColor
    c.myNameColor.value = 0xFF44403F; //cardColor
    c.headingTextColor.value = 0xFF44403F; //cardColor
    c.myInfoColor.value = 0xFF63A15F; //buttonColor
    c.inputLabelColor.value = 0xFF63A15F; //buttonColor
    c.appbarTextColor.value = 0xFFF5F6F0; //cardColor
  } else if (theme == 'woods') {
    c.backgroundColor.value = 0xFF5D7772;
    c.buttonColor.value = 0xFF152D2E;
    c.errorColor.value = 0xFFFF652F;
    c.appbarColor.value = 0xFF152D2E; //buttonColor
    c.cardColor.value = 0xFFB6E2D3;
    c.dividerColor.value = 0xFF43616F;
    c.iconColor.value = 0xFF152D2E; //buttonColor
    c.myNameColor.value = 0xFFB6E2D3; //cardColor
    c.headingTextColor.value = 0xFFB6E2D3; //cardColor
    c.myInfoColor.value = 0xFF152D2E; //buttonColor
    c.inputLabelColor.value = 0xFF152D2E; //buttonColor
    c.appbarTextColor.value = 0xFFB6E2D3; //cardColor
  } else if (theme == 'peace') {
    c.backgroundColor.value = 0xFFC1C8E4;
    c.buttonColor.value = 0xFF5AB9EA;
    c.errorColor.value = 0xFFFD49A0;
    c.appbarColor.value = 0xFF5AB9EA; //buttonColor
    c.cardColor.value = 0xFF84CEEB;
    c.dividerColor.value = 0xFF8860D0;
    c.iconColor.value = 0xFF5AB9EA; //buttonColor
    c.myNameColor.value = 0xFF44318D; //cardColor
    c.headingTextColor.value = 0xFF44318D; //cardColor
    c.myInfoColor.value = 0xFF44318D; //buttonColor
    c.inputLabelColor.value = 0xFF44318D; //buttonColor
    c.appbarTextColor.value = 0xFF44318D; //cardColor
  } else if (theme == 'cool') {
    c.backgroundColor.value = 0xFF647C90;
    c.buttonColor.value = 0xFF4E4F50;
    c.errorColor.value = 0xFFF1C83A;
    c.appbarColor.value = 0xFF4E4F50;
    c.cardColor.value = 0xFFE2DED0;
    c.dividerColor.value = 0xFF746C70;
    c.iconColor.value = 0xFF4E4F50;
    c.myNameColor.value = 0xFFE2DED0;
    c.headingTextColor.value = 0xFFE2DED0;
    c.myInfoColor.value = 0xFF4E4F50;
    c.inputLabelColor.value = 0xFF4E4F50;
    c.appbarTextColor.value = 0xFFE2DED0;
  } else if (theme == 'beachy') {
    c.backgroundColor.value = 0xFF223C60;
    c.buttonColor.value = 0xFF446FA0;
    c.errorColor.value = 0xFFC44B4F;
    c.appbarColor.value = 0xFF446FA0; //buttonColor
    c.cardColor.value = 0xFFD6DDE0;
    c.dividerColor.value = 0xFF51555B;
    c.iconColor.value = 0xFF446FA0; //buttonColor
    c.myNameColor.value = 0xFFD6DDE0; //cardColor
    c.headingTextColor.value = 0xFFD6DDE0; //cardColor
    c.myInfoColor.value = 0xFF446FA0; //buttonColor
    c.inputLabelColor.value = 0xFF446FA0; //buttonColor
    c.appbarTextColor.value = 0xFFD6DDE0; //cardColor
  } else if (theme == 'bark') {
    c.backgroundColor.value = 0xFF5C5350;
    c.buttonColor.value = 0xFF3C3630;
    c.errorColor.value = 0xFFC44B4F;
    c.appbarColor.value = 0xFF3C3630;
    c.cardColor.value = 0xFFD6DDE0;
    c.dividerColor.value = 0xFFBCBEC0;
    c.iconColor.value = 0xFF5C5350;
    c.myNameColor.value = 0xFFD6DDE0;
    c.headingTextColor.value = 0xFFD6DDE0;
    c.myInfoColor.value = 0xFF3C3630;
    c.inputLabelColor.value = 0xFF3C3630;
    c.appbarTextColor.value = 0xFFBCBEC0;
  } else if (theme == 'red') {
    c.backgroundColor.value = 0xFFF7BEC0;
    c.buttonColor.value = 0xFFC85250;
    c.errorColor.value = 0xFFC44B4F;
    c.appbarColor.value = 0xFFC85250;
    c.cardColor.value = 0xFFE9EAE0;
    c.dividerColor.value = 0xFFE9EAE0;
    c.iconColor.value = 0xFFC85250;
    c.myNameColor.value = 0xFFE7625F;
    c.headingTextColor.value = 0xFFE7625F;
    c.myInfoColor.value = 0xFFC85250;
    c.inputLabelColor.value = 0xFFC85250;
    c.appbarTextColor.value = 0xFFE9EAE0;
  } else if (theme == 'revolt') {
    c.backgroundColor.value = 0xFF2D2F3F;
    c.buttonColor.value = 0xFF5F80F7;
    c.errorColor.value = 0xFFAA5266;
    c.appbarColor.value = 0xFF5F80F7; //buttonColor
    c.cardColor.value = 0xFFD6DDE0;
    c.dividerColor.value = 0xFF51555B;
    c.iconColor.value = 0xFF2D2F3F; //buttonColor
    c.myNameColor.value = 0xFFD6DDE0; //cardColor
    c.headingTextColor.value = 0xFFD6DDE0; //cardColor
    c.myInfoColor.value = 0xFF446FA0; //buttonColor
    c.inputLabelColor.value = 0xFF446FA0; //buttonColor
    c.appbarTextColor.value = 0xFFD6DDE0; //cardColor
  }
}
