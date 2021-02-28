import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WA Number Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String phoneNumber;
String phoneIsoCode;
final _formKey = GlobalKey<FormState>();
bool visible = false;
String confirmedNumber = '';


class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WA Number Converter'),
      ),
      body: _buildForm(),
    );
  }
}

Widget _buildForm() {
  return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[_buildNumberPhoneField(),_buildNumberPhoneFielde(), _buildSubmitButton()],
      ));
}

Widget _buildNumberPhoneField() {
  return TextFormField(
    decoration: InputDecoration(labelText: 'Number Phone'),
    validator: (value) {
      if (value.isEmpty) {
        return 'Please Enter Number Phone';
      }
      return null;
    },
  );
}

  Widget _buildNumberPhoneFielde() {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Spacer(flex: 1),
            InternationalPhoneInput(
              onPhoneNumberChange: onPhoneNumberChange,
              initialPhoneNumber: phoneNumber,
              initialSelection: phoneIsoCode,
              enabledCountries: ['+233', '+1'],
              labelText: "Phone Number",
            ),
            SizedBox(height: 20),
            InternationalPhoneInput(
              decoration: InputDecoration.collapsed(hintText: '(123) 123-1234'),
              onPhoneNumberChange: onPhoneNumberChange,
              initialPhoneNumber: phoneNumber,
              initialSelection: phoneIsoCode,
              enabledCountries: ['+233', '+1'],
              showCountryCodes: false,
              showCountryFlags: true,
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.black,
            ),
            SizedBox(height: 50),
            InternationalPhoneInputText(
              onValidPhoneNumber: onValidPhoneNumber,
            ),
            Visibility(
              child: Text(confirmedNumber),
              visible: visible,
            ),
            Spacer(flex: 2)
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


Widget _buildSubmitButton() {
  return RaisedButton(
    child: Text("Submit"),
    onPressed: () {
      _submitForm();
    },
  );
}

void _submitForm() {
  print('Submitting form');
  if (_formKey.currentState.validate()) {
    print('Form was validated');
  }
}
void onPhoneNumberChange(String number, String internationalizedPhoneNumber, String isoCode) {
    {
       phoneNumber = number;
       phoneIsoCode = isoCode;
    }
}
 void onValidPhoneNumber(String number, String internationalizedPhoneNumber, String isoCode) {
     {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
    }
  }
