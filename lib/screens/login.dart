import 'package:appointment_consultation/constants.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool rememberPasswordValue = false;
  bool isPasswordInvisible = true;
  String loginValue;
  String passwordValue;
  bool _autovalidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                autovalidate: _autovalidate,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: Image.asset(
                        'assets/images/logo.png',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      onSaved: (newValue) {
                        loginValue = newValue;
                      },
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (!Constants.emailValidator.hasMatch(value)) {
                          return 'Insira um email válido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            !isPasswordInvisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordInvisible = !isPasswordInvisible;
                            });
                          },
                        ),
                      ),
                      obscureText: isPasswordInvisible,
                      onSaved: (newValue) {
                        passwordValue = newValue;
                      },
                      validator: (value) {
                        if (value.length < 8) {
                          return 'Sua senha deve conter ao menos 8 caracteres';
                        }
                        return null;
                      },
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          rememberPasswordValue = !rememberPasswordValue;
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: rememberPasswordValue,
                            onChanged: (newValue) {
                              setState(() {
                                rememberPasswordValue = newValue;
                              });
                            },
                            activeColor: Theme.of(context).primaryColor,
                          ),
                          Text('Lembrar minha senha?'),
                        ],
                      ),
                    ),
                    Builder(builder: (localContext) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                              onPressed: () {
                                setState(() {
                                  _autovalidate = false;
                                });
                                _formKey.currentState.reset();
                                Navigator.of(context).pushNamed('Signup');
                              },
                              child: Text('Criar Conta')),
                          RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                Navigator.of(context)
                                    .pushReplacementNamed('Home');
                              } else {
                                setState(() {
                                  _autovalidate = true;
                                });
                                Scaffold.of(localContext).showSnackBar(
                                  SnackBar(
                                    content: Text('Insira dados válidos'),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Acessar',
                              style: Theme.of(context).textTheme.button,
                            ),
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                            ),
                          )
                        ],
                      );
                    })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
