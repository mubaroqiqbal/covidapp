import 'package:connectivity/connectivity.dart';
import 'package:covid19/view/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';


class LoginCustomerApp extends StatefulWidget {
  @override
  _LoginCustomerApp createState() => _LoginCustomerApp();
}

class _LoginCustomerApp extends State<LoginCustomerApp>{
  final _formKey = GlobalKey<FormState>();
  final _formKeyModal = GlobalKey<FormState>();
  bool _isLoading = false;

  String _password;
  String _email;
  String _emailSubscribe;
  bool _obscureText=true;

  var colorEmail = colors.blueText;
  var colorPassword = colors.blueText;
  var colorEmailSubscribe = colors.blueText;

  @override
  void initState() {

    super.initState();
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Keluar'),
        content: new Text('Apakah anda yakin ingin keluar?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('Tidak'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Ya'),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context){
    var media = MediaQuery.of(context).size;

    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  height: media.height,
                ),
                Padding(
                    padding: const EdgeInsets.only(left : 25.0, right: 25.0, bottom: 0.0,top: 60.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            //color: Color.fromRGBO(41, 171, 226, 1),
                            child:Text('Login', style: TextStyle(color: colors.buttonText, fontWeight: FontWeight.w600, fontSize: 24),),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            //color: Color.fromRGBO(41, 171, 226, 1),
                            child:Text('Silahkan Masuk Menggunakan Email dan Password yang anda miliki.', style: TextStyle(color: colors.textColor,),),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text('Email', style: TextStyle(color: colors.blueText),),
                              )
                            ],
                          ),
                          _buildTextFieldEmail(),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text('Password', style: TextStyle(color: colors.textColor),),
                              )
                            ],
                          ),
                          _buildTextFieldPassword(),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            onPressed: () {
                              final form = _formKey.currentState;
                              form.save();
                              Navigator.of(context).pushReplacementNamed('/homeCustomer');
                            },
                            child: Text(
                              "masuk".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            color: colors.buttonBlue,
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Column(
                            children: <Widget>[
                              GestureDetector(
                                child: Text('lupa password'.toUpperCase(), style: TextStyle(color: colors.blueText),),
                                onTap: (){
                                  Navigator.of(context).pushNamed('/lupaPassword');
                                },
                              )
                            ],
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text('Belum punya akun? ', style: TextStyle(color: colors.textColor)),
                              ),
                              GestureDetector(
                                child: Text('Registrasi sekarang', style: TextStyle(color: colors.blueText)),
                                onTap: (){
                                  Navigator.of(context).pushNamed('/registrasiCustomer');
                                },
                              )
                            ],
                          ),
                          SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                    )
                ),
              ],
            ),
          )
        )
    );
  }

  Widget _buildTextFieldPassword() {
    return TextFormField(
      onSaved: (value) => _password = value,
      obscureText: _obscureText,
      onTap: (){
        setState(() {
          colorPassword = colors.blueText;
          colorEmail = colors.textColor;
          colorEmailSubscribe = colors.textColor;
        });
      },
      decoration: InputDecoration(
          hintText: 'Masukkan Password',
          hintStyle: TextStyle(color: colorPassword),
          suffixIcon: new GestureDetector(
            child: Icon(_obscureText==true ? Icons.visibility_off : Icons.visibility, color: colorPassword,),
            onTap: (){
              setState(() {
                if(_obscureText==true){
                  _obscureText=false;
                }else{
                  _obscureText=true;
                }
              });
            },
          ),
          focusColor: colors.blueText
      ),
      cursorColor: colors.blueText,
      validator: (value){
        if(value.isEmpty){
          return 'Password is required';
        }
        return null;
      },
    );
  }

  Widget _buildTextFieldEmailSubscribe() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => _emailSubscribe = value,
      focusNode: FocusNode(canRequestFocus: true,skipTraversal: true),
      onTap: (){
        setState(() {
          colorEmailSubscribe = colors.blueText;
          colorPassword = colors.textColor;
          colorEmail = colors.textColor;
        });
      },
      decoration: InputDecoration(
        hintText: 'example@mail.com',
        hintStyle: TextStyle(color: colorEmailSubscribe),
      ),
      cursorColor: colors.blueText,
    );
  }

  Widget _buildTextFieldEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => _email = value.trimRight(),
      onTap: (){
        setState(() {
          colorEmail = colors.blueText;
          colorPassword = colors.textColor;
          colorEmailSubscribe = colors.textColor;
        });
      },
      style: TextStyle(color: colors.textColor),
      decoration: InputDecoration(
          hintText: 'contoh@mail.com/08XXXXXXXXXX',
          hintStyle: TextStyle(color: colorEmail),
          focusColor: colors.blueText,
          suffixIcon: Icon(Icons.email, color: colorEmail,)
      ),
      cursorColor: colors.blueText,
    );
  }
}