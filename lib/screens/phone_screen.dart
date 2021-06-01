import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import './service_overview_screen.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';

class PhoneScreen extends StatefulWidget {
  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'IND';
  PhoneNumber number = PhoneNumber(isoCode: 'IND');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  print(number.phoneNumber);
                },
                onInputValidated: (bool value) {
                  print(value);
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.DIALOG,
                  backgroundColor: Colors.black,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: TextStyle(color: Colors.black),
                initialValue: number,
                textFieldController: controller,
                inputBorder: OutlineInputBorder(),
              ),
              RaisedButton(
                onPressed: () {
                  formKey.currentState.validate();
                },
                child: Text('validate'),
              ),
              RaisedButton(
                onPressed: () {
                  getPhoneNumber('9034214760');
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ProductsOverviewScreen()));
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'IND');

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
