import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mi_card/services/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:io';

class Controller extends GetxController {
  // CHANGE ALL BORDERS HERE
  var borderRadius = 10.0.obs;

  // STORAGE DATA
  var fileName = 'myData.json'.obs;
  var fileContent = <String, dynamic>{}.obs;
  var fileExists = false.obs;

  // INIT COLORS FOR TEAL THEME
  var myColors = 'revolt'.obs; // RADIO BUTTON
  var backgroundColor = 0xFF2D2F3F.obs;
  var buttonColor = 0xFF5F80F7.obs;
  var errorColor = 0xFFAA5266.obs;
  var appbarColor = 0xFF5F80F7.obs;
  var cardColor = 0xFFD6DDE0.obs;
  var dividerColor = 0xFF51555B.obs;
  var iconColor = 0xFF2D2F3F.obs;
  var myNameColor = 0xFFD6DDE0.obs;
  var headingTextColor = 0xFFD6DDE0.obs;
  var myInfoColor = 0xFF446FA0.obs;
  var inputLabelColor = 0xFF446FA0.obs;
  var appbarTextColor = 0xFFD6DDE0.obs;

  // INIT FONT / AVATAR
  var myFont = 'Pacifico'.obs; // RADIO BUTTON AND FONT FAMILY
  var myAvatar = 'assets/me.jpg'.obs;

  // INIT MY DATA
  var myFirstName = 'FirstName'.obs;
  var myLastName = 'LastName'.obs;
  var myTitle = 'My Title'.obs;
  var myPhone = '123-456-7890'.obs;
  var myEmail = 'myemail@domain.com'.obs;
  var myWebsite = 'website.com'.obs;
  var myLinkedIn = 'LinkedIn handle'.obs;
  var myLink = 'My Link'.obs;
  var myGreeting = 'Thank you for your interest!'.obs;
  var myMessage = 'Have a great day!'.obs;

  // RECIPIENT DATA
  var phone = ''.obs;
  var email = ''.obs;
  var sendMeAMessage = ''.obs;
  var isPhoneValid = true.obs; // IS IT VALID?
  var shouldPhoneValidate = false.obs; // SHOULD IT BE VALIDATED YET?
  var isEmailValid = true.obs; // IS IT VALID?
  var shouldEmailValidate = false.obs; // SHOULD IT BE VALIDATED YET?

  Future<void> updateDataFromFile() async {
    myFirstName.value = fileContent['myFirstName'];
    myLastName.value = fileContent['myLastName'];
    myTitle.value = fileContent['myTitle'];
    myPhone.value = fileContent['myPhone'];
    myEmail.value = fileContent['myEmail'];
    myWebsite.value = fileContent['myWebsite'];
    myLinkedIn.value = fileContent['myLinkedIn'];
    myLink.value = fileContent['myLink'];
    myGreeting.value = fileContent['myGreeting'];
    myMessage.value = fileContent['myMessage'];
    myFont.value = fileContent['myFont'];
    myColors.value = fileContent['myColors'];
    backgroundColor.value = fileContent['backgroundColor'];
    buttonColor.value = fileContent['buttonColor'];
    errorColor.value = fileContent['errorColor'];
    appbarColor.value = fileContent['appbarColor'];
    cardColor.value = fileContent['cardColor'];
    dividerColor.value = fileContent['dividerColor'];
    iconColor.value = fileContent['iconColor'];
    headingTextColor.value = fileContent['headingTextColor'];
    myInfoColor.value = fileContent['myInfoColor'];
    inputLabelColor.value = fileContent['inputLabelColor'];
    myNameColor.value = fileContent['myNameColor'];
    myAvatar.value = fileContent['myAvatar'];
    appbarTextColor.value = fileContent['appbarTextColor'];
  }

  // QUADRUPLE CHECK THAT THERE ARE NO NULL VALUED DISPLAYED ON MICARD SCREEN!!!!
  void checkMyData() {
    myFirstName.value = myFirstName.value == null || myFirstName.value.isEmpty || myFirstName.value.trim().isEmpty || myFirstName.value == '' ? 'FirstName' : myFirstName.value;
    myLastName.value = myLastName.value == null || myLastName.value.isEmpty || myLastName.value.trim().isEmpty || myLastName.value == '' ? 'LastName' : myLastName.value;
    myTitle.value = myTitle.value == null || myTitle.value.isEmpty || myTitle.value.trim().isEmpty || myTitle.value == '' ? 'My Title' : myTitle.value;
    myPhone.value = myPhone.value == null || myPhone.value.isEmpty || myPhone.value.trim().isEmpty || myPhone.value == '' ? '123-456-7890' : myPhone.value;
    myEmail.value = myEmail.value == null || myEmail.value.isEmpty || myEmail.value.trim().isEmpty || myEmail.value == '' ? 'myemail@domain.com' : myEmail.value;
  }

  bool validatePhone() {
    phone.value = phone.value.replaceAll('-', '');
    phone.value = phone.value.replaceAll(' ', '');
    phone.value = phone.value.replaceAll('.', '');
    int length = phone.value.length;
    if (shouldPhoneValidate.value == false || length < 10 || length > 12) {
      isPhoneValid.value = false;
      return false;
    } else {
      Pattern pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
      RegExp regex = new RegExp(pattern);
      bool validate = (regex.hasMatch(phone.value)) ? true : false;
      isPhoneValid.value = validate;
      return validate;
    }
  }

  bool validateEmail() {
    if (shouldEmailValidate.value == false || email.value == '') {
      isEmailValid.value = false;
      return false;
    } else {
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      bool validate = (regex.hasMatch(email.value)) ? true : false;
      isEmailValid.value = validate;
      return validate;
    }
  }

  Future<void> launchPhoneURL() async {
    String phoneNum = phone.value;
    final Uri _phoneLaunchUri = Uri(
      scheme: 'sms',
      path: phoneNum,
    );

    if (await canLaunch(_phoneLaunchUri.toString())) {
      await launch('${_phoneLaunchUri.toString()}?body=${message()}');
      phone.value = '';
      shouldPhoneValidate.value = false;
    } else {
      displayFailSnack(type: 'phone');
      throw 'Could not launch ${phone.value}';
    }
  }

  Future<void> launchEmailURL() async {
    String emailAddress = email.value;
    String subject = 'CONTACT INFORMATION FROM: ${myFirstName.value.toUpperCase()} ${myLastName.value.toUpperCase()}';

    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
    );

    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch('${_emailLaunchUri.toString()}?subject=$subject&body=${message()}');
      email.value = '';
      shouldEmailValidate.value = false;
    } else {
      displayFailSnack(type: 'email');
      throw 'Could not launch ${email.value}';
    }
  }

  Future<void> launchSendMeAMessageURL() async {
    if (sendMeAMessage.value.isNullOrBlank) {
      displayFailSnack(type: 'message');
    } else {
      String theMessage = sendMeAMessage.value;
      String myPhoneNumber = myPhone.value;
      myPhoneNumber = myPhoneNumber.replaceAll('-', '');
      myPhoneNumber = myPhoneNumber.replaceAll(' ', '');
      myPhoneNumber = myPhoneNumber.replaceAll('.', '');
      final Uri _phoneLaunchUri = Uri(
        scheme: 'sms',
        path: myPhoneNumber,
      );

      if (await canLaunch(_phoneLaunchUri.toString())) {
        await launch('${_phoneLaunchUri.toString()}?body=$theMessage');
        sendMeAMessage.value = '';
      } else {
        displayFailSnack(type: 'message');
        throw 'Could not launch ${sendMeAMessage.value}';
      }
    }
  }

  String message() {
    String website = myWebsite.value.isNullOrBlank ? '' : 'Website: ${myWebsite.value}\n';
    String linkedIn = myLinkedIn.value.isNullOrBlank ? '' : 'LinkedIn: ${myLinkedIn.value}\n';
    String link = myLink.value.isNullOrBlank ? '' : 'Link: ${myLink.value}\n';

    return '${myGreeting.value}\n\n'
        'Name: ${myFirstName.value} ${myLastName.value}\n'
        'Title: ${myTitle.value.replaceAll('&', '|')}\n'
        'Phone: ${myPhone.value}\n'
        'Email: ${myEmail.value}\n'
        '$website'
        '$linkedIn'
        '$link'
        '\n'
        '${myMessage.value}\n'
        '${myFirstName.value}';
  }

  String format(String value) {
    value.replaceAll('&', '\&');
    value.replaceAll("'", "\'");
    return value;
  }

  void displaySuccessSnack({String type}) {
    String message = type == 'phone'
        ? 'Text sent!'
        : type == 'email'
            ? 'Email sent!'
            : 'Message sent!';
    Get.snackbar(
      '$message',
      'Thank you!',
      titleText: Text('$message', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.green[800])),
      messageText: Text('Thank you!', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.green[800])),
      icon: Icon(Icons.check_circle_outlined, color: Colors.green[800], size: 40.0),
      duration: Duration(milliseconds: 2000),
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.green[800],
      backgroundColor: Colors.white,
      margin: EdgeInsets.symmetric(vertical: Get.height / 2.5, horizontal: 50.0),
      padding: EdgeInsets.only(left: 30, top: 20.0, bottom: 20.0),
      borderColor: Colors.green[800],
      borderWidth: 2,
      overlayBlur: 3,
      borderRadius: 50.0,
      snackStyle: SnackStyle.FLOATING,
      maxWidth: Get.width / 1.75,
      shouldIconPulse: false,
    );
  }

  void displayFailSnack({String type}) {
    String message = type == 'phone'
        ? 'Text'
        : type == 'email'
            ? 'Email'
            : 'Message';
    Get.snackbar(
      '$message failed...',
      'Please try again.',
      titleText: Text('$message failed...', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.red[800])),
      messageText: Text('Please try again.', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.red[800])),
      icon: Icon(MaterialCommunityIcons.skull_crossbones_outline, color: Colors.red[800], size: 40.0),
      duration: Duration(milliseconds: 2000),
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.red[800],
      backgroundColor: Colors.white,
      margin: EdgeInsets.symmetric(vertical: Get.height / 2.5, horizontal: 50.0),
      padding: EdgeInsets.only(left: 30, top: 20.0, bottom: 20.0),
      borderColor: Colors.red[800],
      borderWidth: 2,
      overlayBlur: 3,
      borderRadius: 50.0,
      snackStyle: SnackStyle.FLOATING,
      maxWidth: Get.width / 1.4,
      shouldIconPulse: false,
    );
  }

  // OPTIONALLY DISPLAY WEBSITE INFORMATION
  Row isWebsite() {
    if (myWebsite.value != null) {
      if (myWebsite.value.length > 0) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.web, color: Color(iconColor.value)),
            SizedBox(width: 10.0),
            Flexible(
              child: Obx(
                () => Text(
                  '${myWebsite.value}',
                  style: kContactInfoText.copyWith(color: Color(myInfoColor.value)),
                  maxLines: 2,
                ),
              ),
            ),
          ],
        );
      }
    }
    return Row();
  }

  // OPTIONALLY DISPLAY LINKED IN INFORMATION
  Row isLinkedIn() {
    if (myLinkedIn.value != null) {
      if (myLinkedIn.value.length > 0) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Ionicons.logo_linkedin, color: Color(iconColor.value)),
            SizedBox(width: 10.0),
            Flexible(
              child: Obx(
                () => Text(
                  '${myLinkedIn.value}',
                  style: kContactInfoText.copyWith(color: Color(myInfoColor.value)),
                  maxLines: 2,
                ),
              ),
            ),
          ],
        );
      }
    }
    return Row();
  }

  // OPTIONALLY DISPLAY ADDITIONAL LINK INFORMATION
  Row isLink() {
    if (myLink.value != null) {
      if (myLink.value.length > 0) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.link, color: Color(iconColor.value)),
            SizedBox(width: 10.0),
            Flexible(
              child: Obx(
                () => Text(
                  '${myLink.value}',
                  style: kContactInfoText.copyWith(color: Color(myInfoColor.value)),
                  maxLines: 2,
                ),
              ),
            ),
          ],
        );
      }
    }
    return Row();
  }

  // ONLY RETURN TRUE IF BOTH FIRST AND LAST NAMES ARE PRESENT
  String isName() {
    if (fileContent['myFirstName'] == null || myFirstName.value == null || myFirstName.value.isEmpty || myFirstName.value.trim().isEmpty || myFirstName.value == 'FirstName') return 'false';
    if (fileContent['myLastName'] == null || myLastName.value == null || myLastName.value.isEmpty || myLastName.value.trim().isEmpty || myLastName.value == 'LastName') return 'false';
    return '${myFirstName.value} ${myLastName.value}';
  }

  // DECORATIVE DIVIDER
  Widget divider() {
    return Divider(
      color: Color(dividerColor.value),
      thickness: 2.0,
      height: 40.0,
    );
  }

  // RETURNS EITHER ASSET OR FILE IMAGE
  CircleAvatar getFileImage() {
    if (myAvatar.value == 'assets/me.jpg') {
      return CircleAvatar(
        backgroundImage: AssetImage(myAvatar.value),
      );
    } else {
      final File fileImage = File(myAvatar.value);
      return CircleAvatar(
        backgroundImage: FileImage(fileImage),
      );
    }
  }

  Text debugger() {
    print('debugger');
    return Text('hi');
  }
}
