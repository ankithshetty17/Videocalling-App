// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';


// Project imports:
import 'constants.dart';
import 'util.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _userIDTextCtrl = TextEditingController(text: 'user_id');
  final _passwordVisible = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    getUniqueUserId().then((userID) async {
      setState(() {
        _userIDTextCtrl.text = userID;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
         child: Stack(
          children: [
      
              Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              logo(),
              const SizedBox(height: 50),
              userIDEditor(),
              passwordEditor(),
              const SizedBox(height: 30),
              signInButton(),
            ],
          ),
          ],
        ),
      ),
    );
  }
  Widget logo() {
    return Center(
      child: RichText(
        text: const TextSpan(
          text: 'VIDEO',
          style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
              text: 'CONFERENCE',
              style: TextStyle(color: Colors.green),
            ),
            TextSpan(text: 'CALL'),
          ],
        ),
      ),
    );
  }

  Widget userIDEditor() {
    return TextFormField(
      controller: _userIDTextCtrl,
      decoration: const InputDecoration(
        labelText: 'Login as(User for user id)',
      ),
    );
  }

  Widget passwordEditor() {
    return ValueListenableBuilder<bool>(
      valueListenable: _passwordVisible,
      builder: (context, isPasswordVisible, _) {
        return TextFormField(
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            labelText: 'Password',
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                _passwordVisible.value = !_passwordVisible.value;
              },
            ),
          ),
        );
      },
    );
  }

  Widget signInButton() {
    return ElevatedButton(
        onPressed: _userIDTextCtrl.text.isEmpty
          ? null
          : () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setString(cacheUserIDKey, _userIDTextCtrl.text);

              currentUser.id = _userIDTextCtrl.text;
              currentUser.name = 'user_${_userIDTextCtrl.text}';

              Navigator.pushNamed(
                context,
                PageRouteNames.home,
              );
            },
        child: Text(
          'SIGNIN',
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(255, 1, 90, 23) ,
          backgroundColor: Color.fromARGB(255, 1, 90, 23),
          minimumSize: const Size(
            double.infinity,
            50,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: Color.fromARGB(255, 1, 90, 23)),
          ),
        ),
    );
    
  }
}
