import 'dart:developer' as developer;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_challenge/api/widgetbook_api.dart';
import 'package:widgetbook_challenge/utils/size_config.dart';

/// The app.
class App extends StatefulWidget {
  /// Creates a new instance of [App].
  const App({
    Key? key,
  }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final WidgetbookApi wbApi = WidgetbookApi();

  /// GlobalKey: This uniquely identifies the Form,
  /// and allows validation of the form in a later step.
  final _formKey = GlobalKey<FormState>();

  late String? _name;
  String _response = '';
  Color _resColor = Colors.red;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Interview Challenge'),
          backgroundColor: Colors.black,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeAreaHorizontal! * 0.05,
                  vertical: SizeConfig.safeAreaVertical! * 0.08,
                ),
                child: TextFormField(
                  onSaved: (text) {
                    _name = text;
                  },
                  // The validator receives the text that the user has entered.
                  validator: (String? value) {
                    _isLoading = false;
                    if (value!.isEmpty) {
                      return 'Name cannot be empty.';
                    } else {
                      final isNameValid =
                          RegExp(r'^[a-zA-Z ]+$').hasMatch(value);
                      if (!isNameValid) {
                        return 'Invalid name!';
                      } else {
                        setState(() {
                          _isLoading = true;
                        });
                      }
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your Name...',
                    hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.grey,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsetsDirectional.all(
                      SizeConfig.safeAreaHorizontal! * 0.06,
                    ),
                  ),
                ),
              ),
              CupertinoButton(
                color: Colors.black,
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      _response = await wbApi.welcomeToWidgetbook(
                        message: _name!,
                      );
                      _resColor = Colors.green;
                      developer.log(_response);
                    } catch (err) {
                      _response = 'Error! Try again later.';
                      _resColor = Colors.red;
                      developer.log('error', error: err);
                    }
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: SizeConfig.safeAreaVertical! * 0.06,
              ),
              if (!_isLoading)
                Text(
                  _response,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: _resColor,
                        fontWeight: FontWeight.bold,
                      ),
                )
              else
                const CircularProgressIndicator(
                  color: Colors.black,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
