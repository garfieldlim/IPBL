import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:glassmorphism/glassmorphism.dart';
import 'package:hydrobuddy/screens/app_localizations.dart';
import 'package:hydrobuddy/screens/grafana_iframe_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _selectedLanguage = "en";
  late AppLocalizations _translations;

  @override
  void initState() {
    super.initState();
    _loadTranslations();
  }

  _loadTranslations() async {
    _translations = AppLocalizations(Locale(_selectedLanguage));
    await _translations.load();
    setState(() {}); // Rebuild widget with new translations
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff96b9d0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
            value: _selectedLanguage,
            items: <String>['en', 'zh_TW', 'ja'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) async {
              setState(() {
                _selectedLanguage = newValue!;
                _loadTranslations();
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: Form(
              child: GlassmorphicContainer(
                width: 500,
                height: 600,
                borderRadius: 20,
                blur: 20,
                alignment: Alignment.bottomCenter,
                border: 2,
                linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.1),
                    ],
                    stops: [
                      0.1,
                      1,
                    ]),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.5),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 250,
                        child: Image(image: AssetImage('assets/Logo.png'))),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(color: Colors.white),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // This is the change
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // This is the change
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // This is the change
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          // Add more validation logic here if needed
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Colors.white),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // This is the change
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // This is the change
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // This is the change
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          // Add more validation logic here if needed
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    CupertinoButton(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        child: Text('Login',
                            style: TextStyle(
                                color: Color(0xff96b9d0), fontSize: 20)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GrafanaIframeScreen()),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
