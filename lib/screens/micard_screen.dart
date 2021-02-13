import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:mi_card/screens/update_screen.dart';
import 'package:mi_card/services/constants.dart';
import 'package:mi_card/services/controller.dart';

class MiCardScreen extends StatefulWidget {
  @override
  _MiCardScreenState createState() => _MiCardScreenState();
}

class _MiCardScreenState extends State<MiCardScreen> {
  final Controller c = Get.find();
  var _phoneController = TextEditingController();
  var _emailController = TextEditingController();
  var _messageController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _gatherData({String type}) async {
    // VALIDATE BEFORE SENDING DATA
    if (type == 'phone') {
      c.shouldPhoneValidate.value = true;
      if (c.validatePhone() == false) {
        FocusManager.instance.primaryFocus.unfocus();
      } else {
        FocusManager.instance.primaryFocus.unfocus();
        await c.launchPhoneURL();
        _phoneController.clear();
        c.shouldPhoneValidate.value = false;
      }
    } else if (type == 'email') {
      c.shouldEmailValidate.value = true;
      if (c.validateEmail() == false) {
        FocusManager.instance.primaryFocus.unfocus();
      } else {
        FocusManager.instance.primaryFocus.unfocus();
        await c.launchEmailURL();
        _emailController.clear();
        c.shouldEmailValidate.value = false;
      }
    } else {
      FocusManager.instance.primaryFocus.unfocus();
      await c.launchSendMeAMessageURL();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // CHECK EVERY TIME THAT THESE VALUES ARE NOT NULL, BLANK, OR ONLY WHITE SPACES
    c.checkMyData();
    return Scaffold(
      backgroundColor: Color(c.backgroundColor.value),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(30.0, 18.0, 30.0, 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // PHOTO
                    Container(
                      width: Get.height / 5,
                      height: Get.height / 5,
                      padding: EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: Color(c.dividerColor.value),
                        shape: BoxShape.circle,
                      ),
                      //
                      child: c.getFileImage(),
                    ),
                    SizedBox(height: 10.0),
                    // NAME
                    Container(
                      height: Get.height / 10,
                      child: FittedBox(
                        child: Obx(
                          () => Text(
                            '${c.myFirstName.value} ${c.myLastName.value}',
                            style: kMyName.copyWith(
                              fontFamily: c.myFont.value,
                              color: Color(c.myNameColor.value),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // TITLE
                    Obx(() => Text(c.myTitle.value.isNullOrBlank ? 'MY TITLE' : '${c.myTitle.value.toUpperCase()}', style: kTitleText.copyWith(color: Color(c.headingTextColor.value)))),
                    // DIVIDER
                    c.divider(),
                    // CONTACT DATA / SETTINGS BUTTON
                    Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Material(
                            elevation: 5.0,
                            color: Color(c.cardColor.value),
                            borderRadius: BorderRadius.circular(c.borderRadius.value),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(15.0, 10.0, 0, 10.0),
                              child: Column(
                                children: [
                                  // PHONE
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.phone, color: Color(c.iconColor.value)),
                                      SizedBox(width: 10.0),
                                      Text(
                                        '${c.myPhone.value}',
                                        style: kContactInfoText.copyWith(
                                          color: Color(c.myInfoColor.value),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // EMAIL
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.email, color: Color(c.iconColor.value)),
                                      SizedBox(width: 10.0),
                                      Flexible(
                                        child: Text(
                                          '${c.myEmail.value}',
                                          style: kContactInfoText.copyWith(
                                            color: Color(c.myInfoColor.value),
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // WEBSITE
                                  c.isWebsite(),
                                  // LINKED IN
                                  c.isLinkedIn(),
                                  // ADDITIONAL LINK
                                  c.isLink(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          flex: 2,
                          child: FloatingActionButton(
                            heroTag: 'updateInformation',
                            onPressed: () => Get.to(UpdateScreen()),
                            child: Icon(Icons.settings),
                            foregroundColor: Color(c.backgroundColor.value),
                            backgroundColor: Color(c.buttonColor.value),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.0),
                    // CALL TO ACTION
                    FittedBox(
                      child: Text('SEND CONTACT INFORMATION TO', style: kTitleText.copyWith(color: Color(c.headingTextColor.value))),
                    ),
                    // DIVIDER
                    c.divider(),
                    // PHONE INPUT / TEXT BUTTON
                    Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Material(
                            elevation: 5.0,
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(c.borderRadius.value),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: _phoneController,
                              style: TextStyle(color: Color(c.inputLabelColor.value), fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(c.buttonColor.value)),
                                ),
                                fillColor: Color(c.cardColor.value),
                                hintText: 'Phone Number',
                                prefixIcon: Icon(Icons.phone, color: Color(c.iconColor.value)),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.delete, color: Color(c.iconColor.value)),
                                  onPressed: () {
                                    _phoneController.clear();
                                    c.shouldPhoneValidate.value = false; // DON'T VALIDATE YET
                                  },
                                ),
                              ),
                              onChanged: (value) {
                                c.phone.value = value;
                                c.validatePhone();
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          flex: 2,
                          child: FloatingActionButton(
                            heroTag: 'sendText',
                            onPressed: () => _gatherData(type: 'phone'),
                            child: Icon(Icons.sms),
                            foregroundColor: Color(c.backgroundColor.value),
                            backgroundColor: Color(c.buttonColor.value),
                          ),
                        ),
                      ],
                    ),
                    // ERROR TEXT
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(() => Text(c.isPhoneValid.value == false && c.shouldPhoneValidate.value == true ? 'Please enter valid phone number' : '',
                              style: kError.copyWith(color: Color(c.errorColor.value)))),
                        ],
                      ),
                    ),
                    // EMAIL INPUT / EMAIL BUTTON
                    Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Material(
                            elevation: 5.0,
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(c.borderRadius.value),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              style: TextStyle(color: Color(c.inputLabelColor.value), fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(c.buttonColor.value)),
                                ),
                                fillColor: Color(c.cardColor.value),
                                hintText: 'Email Address',
                                prefixIcon: Icon(Icons.email, color: Color(c.iconColor.value)),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.delete, color: Color(c.iconColor.value)),
                                  onPressed: () {
                                    _emailController.clear();
                                    c.shouldEmailValidate.value = false; // DON'T VALIDATE YET
                                  },
                                ),
                              ),
                              onChanged: (value) {
                                c.email.value = value;
                                c.validateEmail();
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          flex: 2,
                          child: FloatingActionButton(
                            heroTag: 'sendEmail',
                            onPressed: () => _gatherData(type: 'email'),
                            child: Icon(Icons.email),
                            foregroundColor: Color(c.backgroundColor.value),
                            backgroundColor: Color(c.buttonColor.value),
                          ),
                        ),
                      ],
                    ),
                    // ERROR TEXT
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(() => Text(c.isEmailValid.value == false && c.shouldEmailValidate.value == true ? 'Please enter valid email address' : '',
                              style: kError.copyWith(color: Color(c.errorColor.value)))),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    // GET INFO FROM
                    FittedBox(
                      child: Text('GET CONTACT INFORMATION FROM', style: kTitleText.copyWith(color: Color(c.headingTextColor.value))),
                    ),
                    // DIVIDER
                    c.divider(),
                    // MESSAGE ME BOX
                    Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Material(
                            elevation: 5.0,
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(c.borderRadius.value),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 10,
                              controller: _messageController,
                              style: TextStyle(color: Color(c.inputLabelColor.value), fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(c.buttonColor.value)),
                                ),
                                fillColor: Color(c.cardColor.value),
                                hintText: 'Name\nPhone Number\nEmail Address\nMessage',
                                prefixIcon: Icon(MaterialCommunityIcons.message_text, color: Color(c.iconColor.value)),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.delete, color: Color(c.iconColor.value)),
                                  onPressed: () {
                                    _messageController.clear();
                                  },
                                ),
                              ),
                              onChanged: (value) {
                                c.sendMeAMessage.value = value;
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          flex: 2,
                          child: FloatingActionButton(
                            heroTag: 'sendMessage',
                            onPressed: () => _gatherData(type: 'message'),
                            child: Icon(MaterialCommunityIcons.message_text),
                            foregroundColor: Color(c.backgroundColor.value),
                            backgroundColor: Color(c.buttonColor.value),
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
      ),
    );
  }
}
