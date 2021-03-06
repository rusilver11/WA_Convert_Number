import 'package:WA_Convert_Number/updater.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
        body: new FooterView(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(top: 240.0),
              child: Center(child: _buildForm()),
            ),
          ],
          footer: new Footer(child: _buildCheckUpdate(context)),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: FocusScope(
        node: _node,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNumberPhoneField(),
            _buildSubmitButton(),
          ],
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
          labelStyle: TextStyle(
            color: _node.hasFocus
                ? const Color.fromRGBO(47, 58, 118, 1)
                : const Color.fromRGBO(47, 58, 118, 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(
              color: const Color.fromRGBO(72, 204, 145, 1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(
              color: const Color.fromRGBO(14, 214, 121, 1),
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () => numberphone.clear(),
            icon: Icon(
              Icons.clear,
              color: const Color.fromRGBO(72, 204, 145, 1),
            ),
          ),
          contentPadding: const EdgeInsets.all(24.0),
        ),
        style: GoogleFonts.roboto(
            color: const Color.fromRGBO(47, 58, 118, 1),
            fontSize: 16,
            fontWeight: FontWeight.w600),
        inputFormatters: [
          LengthLimitingTextInputFormatter(14),
        ],
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
    width: Get.width * 0.90,
    height: Get.height * 0.12,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: RaisedButton(
        color: _pressed
            ? const Color.fromRGBO(229, 248, 239, 1)
            : const Color.fromRGBO(72, 204, 145, 1),
        child: new Text("GENERATE",
            style: GoogleFonts.roboto(
                color: const Color.fromRGBO(47, 58, 118, 1),
                fontSize: 16,
                fontWeight: FontWeight.w900)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
          side: BorderSide(color: Colors.white),
        ),
        onPressed: () {
          _submitForm();
          _pressed = !_pressed;
        },
      ),
    ),
  );
}

Widget _buildCheckUpdate(BuildContext context) {
  return ElevatedButton(
    child: new Text(
      "CHECK FOR UPDATE",
      style: GoogleFonts.roboto(
          color: const Color.fromRGBO(47, 58, 118, 1),
          fontSize: 16,
          fontWeight: FontWeight.w700),
    ),
    onPressed: () {
      showMaterialModalBottomSheet(
        expand: false,
        enableDrag: false,
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter modalState) {
            return Container(
              width: Get.width * 0.50,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: new BoxConstraints(
                        maxHeight: Get.height * 0.50,
                        maxWidth: Get.width * 0.50),
                    child: Updater(),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
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
