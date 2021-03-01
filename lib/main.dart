import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

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

final _formKey = GlobalKey<FormState>();
final numberphone = TextEditingController();

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generate WhatsApp"),
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
        children: <Widget>[_buildNumberPhoneField(), _buildSubmitButton()],
      ));
}

Widget _buildNumberPhoneField() {
  return TextFormField(
    decoration: InputDecoration(labelText: "Number Phone"),
    keyboardType: TextInputType.phone,
    controller: numberphone,
    inputFormatters: [
      PhoneInputFormatter(
        allowEndlessPhone: true,
        ),
    ],
    validator: (value) {
      if (value.isEmpty) {
        return "Please Enter Number Phone";
      }
      return null;
    },
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
  if (_formKey.currentState.validate()) {
    _launcURL();
  }
}

_launcURL() async {
  const url = "https://wa.me/";
  if (await canLaunch(url)) {
    await launch(url+""+numberphone.text);
  } else {
    throw AlertDialog(
      content: Text("Failure Generate Number"),
    );
  }
}

void setAlterFormatNumber(){
  PhoneInputFormatter.addAlternativePhoneMasks(
          countryCode: 'Indonesia',
          alternativeMasks: [
          '+00 00 0000-0000',
          '+00 000 0000-0000',
          ],
      );
}

void _replacePhoneMask(){
  PhoneInputFormatter.replacePhoneMask(
    countryCode: 'IND',
    newMask: '+00 000 0000 0000',
);
}