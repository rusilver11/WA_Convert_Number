import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generate WhatsApp Number',
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
final FocusScopeNode _node = FocusScopeNode();

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return FocusWatcher(
        child: Scaffold(
      appBar: null,
      body: _buildForm(),
      resizeToAvoidBottomInset: false,
    ));
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: FocusScope(
        node: _node,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[_buildNumberPhoneField(), _buildSubmitButton()],
        ),
      ),
    );
  }
}

Widget _buildNumberPhoneField() {
  //numberphone.text = "62";
  return IgnoreFocusWatcher(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: "Mobile Number",
            border: OutlineInputBorder(borderSide: BorderSide()),
            //hintText: "Example 62 857 2170 0749",
            suffixIcon: IconButton(
                onPressed: () => numberphone.clear(), icon: Icon(Icons.clear)),
            contentPadding: const EdgeInsets.all(24.0)),
        inputFormatters: [LengthLimitingTextInputFormatter(14)],
        keyboardType: TextInputType.phone,
        controller: numberphone,
        validator: (value) {
          if (value.isEmpty) {
            return "Please Enter Mobile Number";
          }
          return null;
        },
      ),
    ),
  );
}

Widget _buildSubmitButton() {
  bool _pressed = false;
  return SizedBox(
    width: Get.width * 0.70,
    height: Get.height * 0.09,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: RaisedButton(
        color: _pressed ? const Color(0xFF69F0AE) : const Color(0xFF00E676),
        child: new Text("GENERATE",
            style: GoogleFonts.roboto(color: Colors.white)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.white)),
        onPressed: () {
          _submitForm();
          _pressed = !_pressed;
        },
      ),
    ),
  );
}

void _submitForm() {
  if (_formKey.currentState.validate()) {
    _launcURL();
  }
}

void dispose() {
  _node.dispose();
}

_launcURL() async {
  const url = "https://wa.me/";
  if (await canLaunch(url)) {
    if (numberphone.text.substring(0, 2) != "62") {
      await launch(
          url + "" + numberphone.text.replaceFirst(new RegExp(r'[0-9]'), '62'));
    } else {
      await launch(url + "" + numberphone.text);
    }
  } else {
    throw AlertDialog(
      content: Text("Failure Generate Number"),
    );
  }
}
