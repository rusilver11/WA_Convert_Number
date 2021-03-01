import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
        children: <Widget>[_buildNumberPhoneField(), _buildSubmitButton()],
      ));
}

Widget _buildNumberPhoneField() {
  return TextFormField(
    decoration: InputDecoration(labelText: 'Number Phone'),
    keyboardType: TextInputType.phone,
    controller: numberphone,
    validator: (value) {
      if (value.isEmpty) {
        return 'Please Enter Number Phone';
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
    AlertDialog(
      content: Text(_launcURL() + "" + numberphone.text),
    );
  }
}

_launcURL() async {
  String getn = numberphone.text;
  const url = 'https://wa.me/';
  if (await canLaunch(url)) {
    await launch(url + getn);
  } else {
    throw 'Could not lauch $url';
  }
}
