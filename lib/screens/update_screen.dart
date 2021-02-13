import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_card/screens/micard_screen.dart';
import 'package:mi_card/services/constants.dart';
import 'package:mi_card/services/update_constants.dart';
import 'package:path_provider/path_provider.dart';
import '../services/controller.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

// REFERENCE: https://kodestat.gitbook.io/flutter/flutter-json-storage

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final Controller c = Get.find();

  File _jsonFile;
  Directory _dir;
  String _myFont;
  String _myColors;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // ACTIVATE CORRECT RADIO BUTTONS
    _myFont = c.myFont.value;
    _myColors = c.myColors.value;
    // GET USERS FILE AND PATH INFORMATION
    getApplicationDocumentsDirectory().then((Directory directory) {
      _dir = directory;
      _jsonFile = File(_dir.path + "/" + c.fileName.value);
    });
  }

  // TEXT INPUT CONTROLLERS
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _websiteController = TextEditingController();
  TextEditingController _linkedInController = TextEditingController();
  TextEditingController _myLinkController = TextEditingController();
  TextEditingController _greetingController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _titleController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _linkedInController.dispose();
    _myLinkController.dispose();
    _greetingController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _createFile(Map<String, dynamic> content, Directory dir, String fileName) {
    print('creating file');
    File file = File(dir.path + "/" + fileName);
    file.createSync();
    c.fileExists.value = true;
    file.writeAsStringSync(jsonEncode(content));
  }

  void writeToFile(String key, dynamic value) {
    Map<String, dynamic> content = {key: value};
    if (c.fileExists.value) {
      Map<String, dynamic> jsonFileContent = jsonDecode(_jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      _jsonFile.writeAsStringSync(jsonEncode(jsonFileContent));
    } else {
      _createFile(content, _dir, c.fileName.value);
    }
    c.fileContent.value = jsonDecode(_jsonFile.readAsStringSync());
  }

  _imageFromCamera() async {
    PickedFile image = await _picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 300,
    );
    c.myAvatar.value = image == null ? 'assets/me.jpg' : image.path;
  }

  _imageFromGallery() async {
    PickedFile image = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 300,
    );
    c.myAvatar.value = image == null ? 'assets/me.jpg' : image.path;
  }

  void _handleRadioFontChange(String font) {
    setState(() => _myFont = font);
    c.myFont.value = font;
  }

  void _handleRadioColorChange(String colors) {
    setState(() => _myColors = colors);
    c.myColors.value = colors;
    changeColors(colors);
  }

  Future<void> saveData() async {
    if (_firstNameController.text.isNotEmpty) writeToFile('myFirstName', _firstNameController.text);
    if (_lastNameController.text.isNotEmpty) writeToFile('myLastName', _lastNameController.text);
    if (_titleController.text.isNotEmpty) writeToFile('myTitle', _titleController.text);
    if (_phoneController.text.isNotEmpty) writeToFile('myPhone', _phoneController.text);
    if (_emailController.text.isNotEmpty) writeToFile('myEmail', _emailController.text);
    if (_websiteController.text.isNotEmpty) writeToFile('myWebsite', _websiteController.text);
    if (_linkedInController.text.isNotEmpty) writeToFile('myLinkedIn', _linkedInController.text);
    if (_myLinkController.text.isNotEmpty) writeToFile('myLink', _myLinkController.text);
    if (_greetingController.text.isNotEmpty) writeToFile('myGreeting', _greetingController.text);
    if (_messageController.text.isNotEmpty) writeToFile('myMessage', _messageController.text);
    if (c.myAvatar.value.isNotEmpty) writeToFile('myAvatar', c.myAvatar.value);
    c.myFont.value = c.myFont.value.isEmpty ? 'Pacifico' : c.myFont.value;
    c.myColors.value = c.myColors.value.isEmpty ? 'teal' : c.myColors.value;
    c.backgroundColor.value = c.backgroundColor.value == null ? 0xFF008080 : c.backgroundColor.value;
    c.buttonColor.value = c.buttonColor.value == null ? 0xFFF6F6D1 : c.buttonColor.value;
    c.errorColor.value = c.errorColor.value == null ? 0xFFFFFF00 : c.errorColor.value;
    c.appbarColor.value = c.appbarColor.value == null ? 0xFFF6F6D1 : c.appbarColor.value;
    c.cardColor.value = c.cardColor.value == null ? 0xFFFFFFFF : c.cardColor.value;
    c.dividerColor.value = c.dividerColor.value == null ? 0xFFB2DFDB : c.dividerColor.value;
    c.iconColor.value = c.iconColor.value == null ? 0xFF008080 : c.iconColor.value;
    c.myNameColor.value = c.myNameColor.value == null ? 0xFFFFFFFF : c.myNameColor.value;
    c.headingTextColor.value = c.headingTextColor.value == null ? 0xFFFFFFFF : c.headingTextColor.value;
    c.myInfoColor.value = c.myInfoColor.value == null ? 0xFF008080 : c.myInfoColor.value;
    c.inputLabelColor.value = c.inputLabelColor.value == null ? 0xFF008080 : c.inputLabelColor.value;
    c.appbarTextColor.value = c.appbarTextColor.value == null ? 0xFF008080 : c.appbarTextColor.value;
    writeToFile('myFont', c.myFont.value);
    writeToFile('myColors', c.myColors.value);
    writeToFile('backgroundColor', c.backgroundColor.value);
    writeToFile('buttonColor', c.buttonColor.value);
    writeToFile('errorColor', c.errorColor.value);
    writeToFile('appbarColor', c.appbarColor.value);
    writeToFile('cardColor', c.cardColor.value);
    writeToFile('dividerColor', c.dividerColor.value);
    writeToFile('iconColor', c.iconColor.value);
    writeToFile('myNameColor', c.myNameColor.value);
    writeToFile('headingTextColor', c.headingTextColor.value);
    writeToFile('myInfoColor', c.myInfoColor.value);
    writeToFile('inputLabelColor', c.inputLabelColor.value);
    writeToFile('appbarTextColor', c.appbarTextColor.value);
    await c.updateDataFromFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'save',
        foregroundColor: Color(c.appbarTextColor.value),
        backgroundColor: Color(c.buttonColor.value),
        onPressed: () async {
          await saveData();
          Get.to(MiCardScreen());
        },
        icon: Icon(Icons.save),
        label: Text('Save'),
      ),
      backgroundColor: Color(c.backgroundColor.value),
      appBar: AppBar(
        toolbarHeight: 75.0,
        iconTheme: IconThemeData(color: Color(c.appbarTextColor.value)),
        backgroundColor: Color(c.appbarColor.value),
        elevation: 5,
        centerTitle: true,
        leading: FlatButton(
          padding: EdgeInsets.only(left: 15.0),
          child: Icon(Icons.arrow_back_ios, color: Color(c.appbarTextColor.value)),
          onPressed: () => Get.to(MiCardScreen()),
        ),
        title: FittedBox(child: Text('Your Contact Information', style: TextStyle(color: Color(c.appbarTextColor.value)))),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: Get.width * 0.85,
              padding: EdgeInsets.only(bottom: 75.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  c.divider(),
                  FittedBox(child: Text('UPDATE YOUR CONTACT INFORMATION', style: kHeadingText.copyWith(color: Color(c.headingTextColor.value)))),
                  c.divider(),

                  // AVATAR
                  Obx(
                    () => Row(
                      children: [
                        Container(
                          width: 80.0,
                          height: 80.0,
                          padding: EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            color: Color(c.dividerColor.value),
                            shape: BoxShape.circle,
                          ),
                          child: c.getFileImage(),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: FlatButton(
                            height: 80.0,
                            color: Color(c.buttonColor.value),
                            onPressed: () => _imageFromCamera(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(c.borderRadius.value),
                            ),
                            child: Column(
                              children: [
                                FittedBox(child: Text('New Image', textAlign: TextAlign.center, style: TextStyle(color: Color(c.appbarTextColor.value), fontSize: 15.0))),
                                Text('From Camera', textAlign: TextAlign.center, style: TextStyle(color: Color(c.appbarTextColor.value), fontSize: 15.0)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: FlatButton(
                            height: 80.0,
                            color: Color(c.buttonColor.value),
                            onPressed: () => _imageFromGallery(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(c.borderRadius.value),
                            ),
                            child: Column(
                              children: [
                                Text('New Image', textAlign: TextAlign.center, style: TextStyle(color: Color(c.appbarTextColor.value), fontSize: 15.0)),
                                Text('From Gallery', textAlign: TextAlign.center, style: TextStyle(color: Color(c.appbarTextColor.value), fontSize: 15.0)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.0),

                  // FIRST NAME
                  Obx(
                    () => TextField(
                      style: TextStyle(color: Color(c.inputLabelColor.value), fontWeight: FontWeight.bold),
                      decoration: getInputDecoration(value: 'myFirstName').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.delete, color: Color(c.iconColor.value)),
                          onPressed: () {
                            writeToFile('myFirstName', 'FirstName');
                            c.updateDataFromFile();
                            _firstNameController.clear();
                          },
                        ),
                      ),
                      controller: _firstNameController,
                    ),
                  ),
                  SizedBox(height: 10.0),

                  // LAST NAME
                  Obx(
                    () => TextField(
                      style: TextStyle(color: Color(c.inputLabelColor.value), fontWeight: FontWeight.bold),
                      decoration: getInputDecoration(value: 'myLastName').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.delete, color: Color(c.iconColor.value)),
                          onPressed: () {
                            writeToFile('myLastName', 'LastName');
                            c.updateDataFromFile();
                            _lastNameController.clear();
                          },
                        ),
                      ),
                      controller: _lastNameController,
                    ),
                  ),
                  SizedBox(height: 10.0),

                  // TITLE
                  Obx(
                    () => TextField(
                      style: TextStyle(color: Color(c.inputLabelColor.value), fontWeight: FontWeight.bold),
                      decoration: getInputDecoration(value: 'myTitle').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.delete, color: Color(c.iconColor.value)),
                          onPressed: () {
                            writeToFile('myTitle', 'My Title');
                            c.updateDataFromFile();
                            _titleController.clear();
                          },
                        ),
                      ),
                      controller: _titleController,
                    ),
                  ),
                  SizedBox(height: 10.0),

                  // PHONE
                  Obx(
                    () => TextField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Color(c.inputLabelColor.value), fontWeight: FontWeight.bold),
                      decoration: getInputDecoration(value: 'myPhone').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.delete, color: Color(c.iconColor.value)),
                          onPressed: () {
                            writeToFile('myPhone', '123-456-7890');
                            c.updateDataFromFile();
                            _phoneController.clear();
                          },
                        ),
                      ),
                      controller: _phoneController,
                    ),
                  ),
                  SizedBox(height: 10.0),

                  // EMAIL
                  Obx(
                    () => TextField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Color(c.inputLabelColor.value), fontWeight: FontWeight.bold),
                      decoration: getInputDecoration(value: 'myEmail').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.delete, color: Color(c.iconColor.value)),
                          onPressed: () {
                            writeToFile('myEmail', 'myemail@domain.com');
                            c.updateDataFromFile();
                            _emailController.clear();
                          },
                        ),
                      ),
                      controller: _emailController,
                    ),
                  ),
                  SizedBox(height: 10.0),

                  // WEBSITE
                  Obx(
                    () => TextField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Color(c.inputLabelColor.value), fontWeight: FontWeight.bold),
                      decoration: getInputDecoration(value: 'myWebsite').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.delete, color: Color(c.iconColor.value)),
                          onPressed: () {
                            writeToFile('myWebsite', '');
                            c.updateDataFromFile();
                            _websiteController.clear();
                          },
                        ),
                      ),
                      controller: _websiteController,
                    ),
                  ),
                  SizedBox(height: 10.0),

                  // LINKED IN
                  Obx(
                    () => TextField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Color(c.inputLabelColor.value), fontWeight: FontWeight.bold),
                      decoration: getInputDecoration(value: 'myLinkedIn').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.delete, color: Color(c.iconColor.value)),
                          onPressed: () {
                            writeToFile('myLinkedIn', '');
                            c.updateDataFromFile();
                            _linkedInController.clear();
                          },
                        ),
                      ),
                      controller: _linkedInController,
                    ),
                  ),
                  SizedBox(height: 10.0),

                  // ADDITIONAL LINK
                  Obx(
                    () => TextField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Color(c.inputLabelColor.value), fontWeight: FontWeight.bold),
                      decoration: getInputDecoration(value: 'myLink').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.delete, color: Color(c.iconColor.value)),
                          onPressed: () {
                            writeToFile('myLink', '');
                            c.updateDataFromFile();
                            _myLinkController.clear();
                          },
                        ),
                      ),
                      controller: _myLinkController,
                    ),
                  ),
                  SizedBox(height: 10.0),

                  // GREETING
                  Obx(
                    () => TextField(
                      style: TextStyle(color: Color(c.inputLabelColor.value), fontWeight: FontWeight.bold),
                      decoration: getInputDecoration(value: 'myGreeting').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.delete, color: Color(c.iconColor.value)),
                          onPressed: () {
                            writeToFile('myGreeting', '');
                            c.updateDataFromFile();
                            _greetingController.clear();
                          },
                        ),
                      ),
                      controller: _greetingController,
                    ),
                  ),
                  SizedBox(height: 10.0),

                  // MESSAGE
                  Obx(
                    () => TextField(
                      style: TextStyle(color: Color(c.inputLabelColor.value), fontWeight: FontWeight.bold),
                      decoration: getInputDecoration(value: 'myMessage').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.delete, color: Color(c.iconColor.value)),
                          onPressed: () {
                            writeToFile('myMessage', '');
                            c.updateDataFromFile();
                            _messageController.clear();
                          },
                        ),
                      ),
                      controller: _messageController,
                    ),
                  ),
                  SizedBox(height: 10.0),

                  // PREVIEW MESSAGE
                  c.divider(),
                  FittedBox(child: Text('PREVIEW YOUR OUTGOING MESSAGE', style: kHeadingText.copyWith(color: Color(c.headingTextColor.value)))),
                  c.divider(),
                  Card(
                    elevation: 5.0,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Obx(() => Text(c.message(), style: TextStyle(color: Colors.black))),
                          SizedBox(height: 10.0),
                          FloatingActionButton.extended(
                            backgroundColor: Color(c.buttonColor.value),
                            heroTag: 'refresh',
                            onPressed: () async => await saveData(),
                            // elevation: 5.0,
                            icon: Icon(Icons.refresh, color: Color(c.appbarTextColor.value)),
                            label: Text('refresh', style: TextStyle(color: Color(c.appbarTextColor.value))),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // CHOOSE A COLOR SCHEME
                  c.divider(),
                  Text('CHOOSE A COLOR SCHEME', style: kHeadingText.copyWith(color: Color(c.headingTextColor.value))),
                  c.divider(),
                  Theme(
                    data: Theme.of(context).copyWith(unselectedWidgetColor: Color(c.buttonColor.value)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Radio(
                              activeColor: Color(c.buttonColor.value),
                              groupValue: _myColors,
                              value: 'teal',
                              onChanged: _handleRadioColorChange,
                            ),
                            Text('I\'ll Teal You What', style: TextStyle(color: Color(c.headingTextColor.value))),
                            SizedBox(width: 10.0),
                            colorContainer(color: Color(0xFFFFFFFF)),
                            colorContainer(color: Color(0xFFF6F6D1)),
                            colorContainer(color: Color(0xFF008080)),
                            colorContainer(color: Color(0xFFB2DFDB)),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Color(c.buttonColor.value),
                              groupValue: _myColors,
                              value: 'black',
                              onChanged: _handleRadioColorChange,
                            ),
                            Text('Dark Metal', style: TextStyle(color: Color(c.headingTextColor.value))),
                            SizedBox(width: 10.0),
                            colorContainer(color: Color(0xFFD6D6D6)),
                            colorContainer(color: Color(0xFF8C8C8C)),
                            colorContainer(color: Color(0xFF44444C)),
                            colorContainer(color: Color(0xFF0B0909)),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Color(c.buttonColor.value),
                              groupValue: _myColors,
                              value: 'deepBlue',
                              onChanged: _handleRadioColorChange,
                            ),
                            Text('The Deep Blue', style: TextStyle(color: Color(c.headingTextColor.value))),
                            SizedBox(width: 10.0),
                            colorContainer(color: Color(0xFFFFFFFF)), // light
                            colorContainer(color: Color(0xFF4B7BF5)), // dark
                            colorContainer(color: Color(0xFF3500d3)), // med
                            colorContainer(color: Color(0xFF0C0032)), // med
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Color(c.buttonColor.value),
                              groupValue: _myColors,
                              value: 'pastel',
                              onChanged: _handleRadioColorChange,
                            ),
                            Text('Pastel Heroine', style: TextStyle(color: Color(c.headingTextColor.value))),
                            SizedBox(width: 10.0),
                            colorContainer(color: Color(0xFFF3F3E7)),
                            colorContainer(color: Color(0xFF999DA0)),
                            colorContainer(color: Color(0xFFB2C4CB)),
                            colorContainer(color: Color(0xFFF09CA2)),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Color(c.buttonColor.value),
                              groupValue: _myColors,
                              value: 'earthy',
                              onChanged: _handleRadioColorChange,
                            ),
                            Text('Earthy Chic', style: TextStyle(color: Color(c.headingTextColor.value))),
                            SizedBox(width: 10.0),
                            colorContainer(color: Color(0xFFF5F6F0)),
                            colorContainer(color: Color(0xFFC6CDC1)),
                            colorContainer(color: Color(0xFF44403F)),
                            colorContainer(color: Color(0xFF63A15F)),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Color(c.buttonColor.value),
                              groupValue: _myColors,
                              value: 'woods',
                              onChanged: _handleRadioColorChange,
                            ),
                            Text('Evening Woods', style: TextStyle(color: Color(c.headingTextColor.value))),
                            SizedBox(width: 10.0),
                            colorContainer(color: Color(0xFF5D7772)),
                            colorContainer(color: Color(0xFFB6E2D3)),
                            colorContainer(color: Color(0xFF43616F)),
                            colorContainer(color: Color(0xFF152D2E)),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Color(c.buttonColor.value),
                              groupValue: _myColors,
                              value: 'peace',
                              onChanged: _handleRadioColorChange,
                            ),
                            Text('Peace Fuzz', style: TextStyle(color: Color(c.headingTextColor.value))),
                            SizedBox(width: 10.0),
                            colorContainer(color: Color(0xFF5AB9EA)),
                            colorContainer(color: Color(0xFFC1C8E4)),
                            colorContainer(color: Color(0xFF8860D0)),
                            colorContainer(color: Color(0xFF44318D)),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Color(c.buttonColor.value),
                              groupValue: _myColors,
                              value: 'cool',
                              onChanged: _handleRadioColorChange,
                            ),
                            Text('Cool Beans', style: TextStyle(color: Color(c.headingTextColor.value))),
                            SizedBox(width: 10.0),
                            colorContainer(color: Color(0xFF746C70)), // light
                            colorContainer(color: Color(0xFF4E4F50)), // dark
                            colorContainer(color: Color(0xFFE2DED0)), // med
                            colorContainer(color: Color(0xFF647C90)), // med
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Color(c.buttonColor.value),
                              groupValue: _myColors,
                              value: 'beachy',
                              onChanged: _handleRadioColorChange,
                            ),
                            Text('Sandy Beach', style: TextStyle(color: Color(c.headingTextColor.value))),
                            SizedBox(width: 10.0),
                            colorContainer(color: Color(0xFF51555B)), // light
                            colorContainer(color: Color(0xFF223C60)), // dark
                            colorContainer(color: Color(0xFF446FA0)), // med
                            colorContainer(color: Color(0xFFD6DDE0)), // med
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Color(c.buttonColor.value),
                              groupValue: _myColors,
                              value: 'bark',
                              onChanged: _handleRadioColorChange,
                            ),
                            Text('Barking Up the Tree', style: TextStyle(color: Color(c.headingTextColor.value))),
                            SizedBox(width: 10.0),
                            colorContainer(color: Color(0xFF3C3630)), // light
                            colorContainer(color: Color(0xFF5C5350)), // dark
                            colorContainer(color: Color(0xFFBCBEC0)), // med
                            colorContainer(color: Color(0xFFE5DACE)), // med
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Color(c.buttonColor.value),
                              groupValue: _myColors,
                              value: 'red',
                              onChanged: _handleRadioColorChange,
                            ),
                            Text('Strawberry Cream', style: TextStyle(color: Color(c.headingTextColor.value))),
                            SizedBox(width: 10.0),
                            colorContainer(color: Color(0xFFE9EAE0)),
                            colorContainer(color: Color(0xFFF7BEC0)),
                            colorContainer(color: Color(0xFFC85250)),
                            colorContainer(color: Color(0xFFE7625F)),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Color(c.buttonColor.value),
                              groupValue: _myColors,
                              value: 'revolt',
                              onChanged: _handleRadioColorChange,
                            ),
                            Text('Revolt Wind', style: TextStyle(color: Color(c.headingTextColor.value))),
                            SizedBox(width: 10.0),
                            colorContainer(color: Color(0xFFD6DDE0)),
                            colorContainer(color: Color(0xFF5F80F7)),
                            colorContainer(color: Color(0xFF3A3D52)),
                            colorContainer(color: Color(0xFF2D2F3F)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // CHOOSE FONT
                  c.divider(),
                  Text('CHOOSE A FONT', style: kHeadingText.copyWith(color: Color(c.headingTextColor.value))),
                  c.divider(),
                  Theme(
                    data: Theme.of(context).copyWith(unselectedWidgetColor: Color(c.buttonColor.value)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Row(
                            children: [
                              Radio(
                                activeColor: Color(c.buttonColor.value),
                                groupValue: _myFont,
                                value: 'RedHat',
                                onChanged: _handleRadioFontChange,
                              ),
                              Text(
                                c.isName() == 'false' ? 'RedHat Font' : c.isName(),
                                style: kMyName.copyWith(
                                  fontFamily: 'RedHat',
                                  color: Color(c.myNameColor.value),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              Radio(
                                activeColor: Color(c.buttonColor.value),
                                groupValue: _myFont,
                                value: 'Pacifico',
                                onChanged: _handleRadioFontChange,
                              ),
                              Text(
                                c.isName() == 'false' ? 'Pacifico Font' : c.isName(),
                                style: kMyName.copyWith(
                                  fontFamily: 'Pacifico',
                                  color: Color(c.myNameColor.value),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              Radio(
                                activeColor: Color(c.buttonColor.value),
                                groupValue: _myFont,
                                value: 'DancingScript',
                                onChanged: _handleRadioFontChange,
                              ),
                              Text(
                                c.isName() == 'false' ? 'DancingScript Font' : c.isName(),
                                style: kMyName.copyWith(
                                  fontFamily: 'DancingScript',
                                  color: Color(c.myNameColor.value),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              Radio(
                                activeColor: Color(c.buttonColor.value),
                                groupValue: _myFont,
                                value: 'Niconne',
                                onChanged: _handleRadioFontChange,
                              ),
                              Text(
                                c.isName() == 'false' ? 'Niconne Font' : c.isName(),
                                style: kMyName.copyWith(
                                  fontFamily: 'Niconne',
                                  color: Color(c.myNameColor.value),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              Radio(
                                activeColor: Color(c.buttonColor.value),
                                groupValue: _myFont,
                                value: 'IndieFlower',
                                onChanged: _handleRadioFontChange,
                              ),
                              Text(
                                c.isName() == 'false' ? 'IndieFlower Font' : c.isName(),
                                style: kMyName.copyWith(
                                  fontFamily: 'IndieFlower',
                                  color: Color(c.myNameColor.value),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              Radio(
                                activeColor: Color(c.buttonColor.value),
                                groupValue: _myFont,
                                value: 'Parisienne',
                                onChanged: _handleRadioFontChange,
                              ),
                              Text(
                                c.isName() == 'false' ? 'Parisienne Font' : c.isName(),
                                style: kMyName.copyWith(
                                  fontFamily: 'Parisienne',
                                  color: Color(c.myNameColor.value),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              Radio(
                                activeColor: Color(c.buttonColor.value),
                                groupValue: _myFont,
                                value: 'SwankyandMooMoo',
                                onChanged: _handleRadioFontChange,
                              ),
                              Text(
                                c.isName() == 'false' ? 'SwankyMooMoo Font' : c.isName(),
                                style: kMyName.copyWith(
                                  fontFamily: 'SwankyandMooMoo',
                                  color: Color(c.myNameColor.value),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              Radio(
                                activeColor: Color(c.buttonColor.value),
                                groupValue: _myFont,
                                value: 'BerkshireSwash',
                                onChanged: _handleRadioFontChange,
                              ),
                              Text(
                                c.isName() == 'false' ? 'BerkshireSwash Font' : c.isName(),
                                style: kMyName.copyWith(
                                  fontFamily: 'BerkshireSwash',
                                  color: Color(c.myNameColor.value),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              Radio(
                                activeColor: Color(c.buttonColor.value),
                                groupValue: _myFont,
                                value: 'SourceSansPro',
                                onChanged: _handleRadioFontChange,
                              ),
                              Text(
                                c.isName() == 'false' ? 'SourceSansPro Font' : c.isName(),
                                style: kMyName.copyWith(
                                  fontFamily: 'SourceSansPro',
                                  color: Color(c.myNameColor.value),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              Radio(
                                activeColor: Color(c.buttonColor.value),
                                groupValue: _myFont,
                                value: 'Sacramento',
                                onChanged: _handleRadioFontChange,
                              ),
                              Text(
                                c.isName() == 'false' ? 'Sacramento Font' : c.isName(),
                                style: kMyName.copyWith(
                                  fontFamily: 'Sacramento',
                                  color: Color(c.myNameColor.value),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              Radio(
                                activeColor: Color(c.buttonColor.value),
                                groupValue: _myFont,
                                value: 'Righteous',
                                onChanged: _handleRadioFontChange,
                              ),
                              Text(
                                c.isName() == 'false' ? 'Righteous Font' : c.isName(),
                                style: kMyName.copyWith(
                                  fontFamily: 'Righteous',
                                  color: Color(c.myNameColor.value),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              Radio(
                                activeColor: Color(c.buttonColor.value),
                                groupValue: _myFont,
                                value: 'PoiretOne',
                                onChanged: _handleRadioFontChange,
                              ),
                              Text(
                                c.isName() == 'false' ? 'PoiretOne Font' : c.isName(),
                                style: kMyName.copyWith(
                                  fontFamily: 'PoiretOne',
                                  color: Color(c.myNameColor.value),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
