import 'package:flutter/material.dart';
import 'package:local_client_one/Languages/languages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:local_client_one/localization/appLocalization.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  void setLocale(Locale local) {
    setState(() {
      _locale = local;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      locale: _locale,
      localizationsDelegates: [
        ApplicationLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English, no country code
        const Locale('ar', 'EG'), // Spanish, no country code
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale.languageCode &&
              locale.countryCode == deviceLocale.countryCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  _changeLanguage(language) {
    Locale _temp;
    print(language.languageCode);
    switch (language.languageCode) {
      case 'us':
        _temp = Locale(language.languageCode, 'US');
        break;
      case 'ar':
        _temp = Locale(language.languageCode, 'EG');
        break;
      default:
        _temp = Locale(language.languageCode, 'US');
        break;
    }

    MyApp.setLocale(context, _temp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ApplicationLocalization.of(context)
              .getTranslatedValue('home_page_title'),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(15),
            child: DropdownButton(
              underline: SizedBox(),
              onChanged: (ApplicationLanguages language) {
                _changeLanguage(language);
              },
              icon: Icon(
                Icons.language,
                color: Colors.white,
              ),
              items: ApplicationLanguages.getLanguages()
                  .map<DropdownMenuItem<ApplicationLanguages>>(
                    (lang) => DropdownMenuItem(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(lang.flag),
                          Text(lang.name),
                        ],
                      ),
                      value: lang,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ApplicationLocalization.of(context)
                  .getTranslatedValue('home_body_text'),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
