import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Widgets/EmailVerificationScreen.dart';
import '../Resources/firebase_options.dart';
import '../Resources/firebase_constants.dart';

class _MyHomePageState extends State<MyHomePage> {
  final usernameCon = TextEditingController();
  final emailCon = TextEditingController();
  final passwordCon = TextEditingController();
  Future _updateProfile() async {
    setState(() {
    });
    final updates = {
      'username': usernameCon.text,
      'password': passwordCon.text,
      'email' : emailCon.text
    };
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailCon.text, password: passwordCon.text);
      FirebaseFirestore.instance.collection("Sarajevo").add(updates);
      Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const EmailVerificationScreen()));
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("weak");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        print("emailinuse");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The account already exists for that email.')));
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }

    // try {
    //   FirebaseFirestore.instance.collection("Sarajevo").add(updates);
    //   Navigator.pushNamed(context, '/login');
    // } on PostgrestException catch (error) {
    //   return Text("error");
    // } catch (error) {
    //   print("error");
    // }
  }
  @override
  void dispose() {
    usernameCon.dispose();
    emailCon.dispose();
    passwordCon.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(children: <Widget>[
                TextFormField(
                    controller: usernameCon,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Username',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        print("empty");
                        return "ADD TEXT";
                      }
                      return null;
                    }),
                TextFormField(
                    controller: emailCon,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Email',
                    ),
                    validator: (String? value) {
                      final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+$)';
                      final regExp = RegExp(pattern);
                      if (value == null || value.isEmpty) {
                        return "Please Input Something";
                      } else if (!regExp.hasMatch(value)) {
                        return 'Enter a valid email';
                      } else {
                        return null;
                      }
                    }),
                TextFormField(
                    controller: passwordCon,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Input Something";
                      } else {
                        return null;
                      }
                    }),
                Row(
                    children:[
                      ElevatedButton(
                          onPressed: () {
                            _updateProfile();
                          },
                          child: const Text('Submit'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.cyan[800],
                            onPrimary: Colors.white,
                            textStyle: TextStyle(fontSize:20),
                          )
                      ), ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Padding( padding: EdgeInsets.only(left: 20.0, right: 20.0), child: const Text('Login')),
                      )]
                ),
              ]),
            ),
          ],
        ),
      ),
    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class loginPage extends StatefulWidget {
  const loginPage({super.key, required this.title});
  final String title;
  @override
  State<loginPage> createState() => _loginPageState();
}

class homepage extends StatefulWidget {
  const homepage({super.key, required this.title});
  final String title;
  @override
  State<homepage> createState() => _homeState();
}

class _homeState extends State<homepage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('logout'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrangeAccent[800],
                    onPrimary: Colors.white,
                    textStyle: TextStyle(fontSize:20),
                  )
              ),
            ]),
      ),
    );
  }
}
class _loginPageState extends State<loginPage> {
  showAlertDialog(BuildContext context, title, text) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                  children: <Widget>[
                    TextFormField(
                        controller: emailControl,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Email',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "ADD TEXT";
                          }
                          return null;
                        }),
                    TextFormField(
                        controller: passwordControl,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Password',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Input Something";
                          } else {
                            return null;
                          }
                        }),
                    ElevatedButton(
                        onPressed: () async {
                          // UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailControl.text, password: passwordControl.text);
                          var goThrough = false;
                          FirebaseFirestore.instance.collection("Sarajevo")
                              .where(
                              "username", isEqualTo: passwordControl.text)
                              .where("password", isEqualTo: emailControl.text)
                              .get()
                              .then(
                                  (querySnapshot) {
                                Navigator.pushNamed(
                                    context, '/homePage');
                              }
                          );
                        },
                        child: const Text('Submit'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.cyan[800],
                          onPrimary: Colors.white,
                          textStyle: TextStyle(fontSize:20),
                        )
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                        child: const Text('Sign up'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[800],
                          onPrimary: Colors.white,
                          textStyle: TextStyle(fontSize:20),
                        )
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

