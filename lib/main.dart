import 'package:flutter/material.dart';

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

final _formKey = GlobalKey<FormState>();

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
  print('Submitting form');
  if (_formKey.currentState.validate()) {
    print('Form was validated');
  }
}
