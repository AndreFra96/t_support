import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:support/models/rca_user.dart';
import 'package:support/pages/common/splash.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String error;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print("WIDGET BUILTED");
    RcaUser rcaUser = Provider.of<RcaUser>(context);
    TextEditingController _userCodeController = new TextEditingController();
    TextEditingController _pivaController = new TextEditingController();
    void _loginAttempt() async {
      setState(() {
        loading = true;
      });
      //Splash dura almeno un secondo
      await Future.delayed(const Duration(seconds: 1), () {});
      String response =
          await rcaUser.logIn(_userCodeController.text, _pivaController.text);
      setState(() {
        error = response;
        loading = false;
      });
    }

    void _requestCustomerId() {
      print("request user code");
    }

    return loading
        ? Splash()
        : Scaffold(
            body: Container(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/titles/t_support_purple.png",
                        fit: BoxFit.contain,
                        height: 100,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0),
                                    borderSide: new BorderSide(),
                                  ),
                                  contentPadding: EdgeInsets.only(left: 10),
                                  hintText: "Codice cliente",
                                  counterText: "",
                                ),
                                controller: _userCodeController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Inserire il codice cliente";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                maxLength: 11,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0),
                                    borderSide: new BorderSide(),
                                  ),
                                  contentPadding: EdgeInsets.only(left: 10),
                                  hintText: "Partita iva",
                                  counterText: "",
                                ),
                                controller: _pivaController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Inserire la partita iva";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            if (error != null)
                              Text(
                                error,
                                style: TextStyle(color: Colors.red),
                              ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 38,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.green),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _loginAttempt();
                                    }
                                  },
                                  child: Text(
                                    "Accedi",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      Text("Richiedi il tuo codice cliente")
                    ],
                  ),
                ),
              )),
            ),
            bottomNavigationBar: Container(
              child: Image.asset(
                "assets/images/logorcatrasp.png",
                fit: BoxFit.contain,
                height: 40,
              ),
              padding: const EdgeInsets.only(bottom: 20),
            ),
          );
  }
}
