// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_demo/login_page.dart';

import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// Project imports:
import 'constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  /// Users who use the same callID can in the same call.
  final callIDTextCtrl = TextEditingController(text: 'call_id');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          
          child: Stack(  
            children: [
               Positioned(
            top: 30, // Adjust the top position as needed
            left: 0, // Adjust the left position as needed
            child: IconButton(
          icon: Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
          Navigator.pushReplacement(
                           context,
                           MaterialPageRoute(builder: (context) => LoginPage()),
                       ); 
          },
        ),
          ),
           
              Positioned(
                
                top: 30,
                right: MediaQuery.of(context).size.width / 19,
                
                child: logoutButton(),
              ),
            
              Positioned(
               
                  top: 100,
             left: MediaQuery.of(context).size.width / 4.5,
                child: Text('LoggingIn as: ${currentUser.id}',
                 style: TextStyle(color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold),),
              ),
            
              joinCallContaier(),
            ],
          ),
        ),
      ),
    );
  }

Widget logoutButton() {
  return Center(
    child: Ink(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color:Color.fromARGB(255, 224, 0, 0),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Color.fromARGB(255, 224, 0, 0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.exit_to_app_sharp),
            iconSize: 25,
            color: Colors.white,
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove(cacheUserIDKey);

              Navigator.pushNamed(
                context,
                PageRouteNames.login,
              );
            },
          ),
         
        ],
      ),
    ),
  );
}

  Widget joinCallContaier() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
         
          children: [
            Expanded(
              child: TextFormField(
                controller: callIDTextCtrl,
                decoration: const InputDecoration(
                  labelText: 'join a group call by id',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (ZegoUIKitPrebuiltCallMiniOverlayMachine().isMinimizing) {
                  /// when the application is minimized (in a minimized state),
                  /// disable button clicks to prevent multiple PrebuiltCall components from being created.
                  return;
                }

                Navigator.pushNamed(context, PageRouteNames.prebuilt_call,
                    arguments: <String, String>{
                      PageParam.call_id: callIDTextCtrl.text.trim(),
                    });
              },
              child: const Text('JOIN'),
               style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(255, 1, 90, 23) ,
          backgroundColor: Color.fromARGB(255, 1, 90, 23),
         
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: Color.fromARGB(255, 1, 90, 23)),
          ),
        ),
            ),
          ],
        ),
      ),
    );
  }
}