import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mibus/src/Screens/Screens/DashBoard/Home.dart';
import 'package:mibus/src/Screens/Screens/Login/forgetpassword.dart';
import 'package:mibus/src/Screens/Util/reusables.dart';
import 'package:mibus/src/Screens/services_Google/firebase_Services.dart';

void SignInMethodGA(context) {
  final TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    context: context,
    backgroundColor: Colors.white,
    builder: (context) => Container(
      height: 900,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 20, left: 30)),
          const Text(
            "Registrate",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          reusablesTextField("Ingresa correo", Icons.percent_outlined, false,
              _emailTextController),
          const SizedBox(
            height: 10,
          ),
          reusablesTextField('Ingresa tu contraseña', Icons.password_outlined,
              false, _passwordTextController),
          const SizedBox(
            height: 30,
          ),
          FirebaseButton(context, 'Registrarse', () async {}),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                elevation: 10,
                onPressed: () async {
                  await FirebaseServices().signInWithGoogle();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Home2()));
                },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                    side: const BorderSide(color: Colors.black)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/google.png",
                    ),
                    Text("   Registrate Con Google"),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              MaterialButton(
                elevation: 40,
                onPressed: () {
                  Fluttertoast.showToast(
                      gravity: ToastGravity.BOTTOM,
                      msg: "Proximamente",
                      toastLength: Toast.LENGTH_LONG,
                      textColor: Colors.white,
                      backgroundColor: Colors.black);
                },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                    side: const BorderSide(color: Colors.black)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/apple.png",
                    ),
                    Text("   Registrate Con Apple"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

void SignInMethod2(context) {
  bool? isChecked = false;
  final TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  showModalBottomSheet(
    elevation: 30,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    context: context,
    backgroundColor: Colors.white,
    builder: (context) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      height: 800,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 20, left: 40)),
          const Text(
            "Ingresa tu correo y contraseña",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          reusablesTextField("Ingresa correo", Icons.percent_outlined, false,
              _emailTextController),
          const SizedBox(
            height: 20,
          ),
          reusablesTextField('Ingresa tu contraseña', Icons.password_outlined,
              false, _passwordTextController),
          const SizedBox(
            height: 1,
          ),
          forgetpassword(context),
          FirebaseButton(context, 'Iniciar Sesion', () async {
            FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text)
                .then((value) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home2()));
            }).onError((error, stackTrace) {
              print("Error ${error.toString()}");
            });
          }),
          CheckBos(),
        ],
      ),
    ),
  );
}

Widget forgetpassword(BuildContext context) {
  return Container(
    height: 30,
      alignment: Alignment.bottomRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ForgotPassword()));
        },
        child: Text(
          "Olvidaste tu contraseña?",
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.black),
        ),
      )
      );
}

class CheckBos extends StatefulWidget {
  const CheckBos({super.key});

  @override
  State<CheckBos> createState() => _CheckBosState();
}

class _CheckBosState extends State<CheckBos> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          
          activeColor: Colors.black,
          value: isChecked,
          onChanged: (newbool) {
            setState(() {
              isChecked = newbool;
            });
          },
        ),
        Text("Recordar Usuario")
      ],
    );
  }
}
