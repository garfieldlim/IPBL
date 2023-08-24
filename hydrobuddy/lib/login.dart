import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:glassmorphism/glassmorphism.dart';
import 'package:hydrobuddy/mqttgrafana.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _selectedLanguage = "en";

  // Map for translations
  Map<String, Map<String, String>> translations = {
    'en': {
      'email': 'Email',
      'enter_email': 'Enter your email',
      'password': 'Password',
      'enter_password': 'Enter your password',
      'login': 'Login',
    },
    'zh_TW': {
      'email': '電子郵件',
      'enter_email': '輸入您的電子郵件',
      'password': '密碼',
      'enter_password': '輸入您的密碼',
      'login': '登錄',
    },
    'jp': {
      'email': 'メール',
      'enter_email': 'メールアドレスを入力してください',
      'password': 'パスワード',
      'enter_password': 'パスワードを入力してください',
      'login': 'ログイン',
    },
    // ... Add more languages here as needed
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff96b9d0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
            value: _selectedLanguage,
            items: <String>['en', 'zh_TW', 'jp'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedLanguage = newValue!;
                print('Selected language: $_selectedLanguage');
              });

              // var langProvider =
              // Provider.of<LanguageProvider>(context, listen: false);
              // Locale newLocale;

              switch (_selectedLanguage) {
                case 'en':
                  // newLocale = Locale('en');
                  break;
                case 'zh_TW':
                  // newLocale = Locale('zh', 'TW');
                  break;
                case 'ja':
                  // newLocale = Locale('ja');
                  break;
                default:
                // newLocale = Locale('en');
              }

              // langProvider.changeLocale(newLocale);

              // Navigate back to LoginPage in the new language.
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => LoginPage()),
              // );
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
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: translations[_selectedLanguage]
                              ?['enter_email'],
                          hintStyle: TextStyle(color: Colors.white),
                          labelText: translations[_selectedLanguage]?['email'],
                          labelStyle: TextStyle(color: Colors.white),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: translations[_selectedLanguage]
                              ?['enter_password'],
                          hintStyle: TextStyle(color: Colors.white),
                          labelText: translations[_selectedLanguage]
                              ?['password'],
                          labelStyle: TextStyle(color: Colors.white),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    CupertinoButton(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      child: Text(
                          translations[_selectedLanguage]?['login'] ?? 'Login',
                          style: TextStyle(
                              color: Color(0xff96b9d0), fontSize: 20)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GrafanaIframeScreen()),
                        );
                      },
                    ),
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
