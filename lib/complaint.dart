import 'package:flutter/material.dart';

import 'package:complaint/list.dart';
import 'package:complaint/login.dart';
import 'package:complaint/authentication.dart';

class Complaint extends StatelessWidget {
  const Complaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height, width;

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo[500],
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'PERBADANAN PR1MA MALAYSIA',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [

        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          AuthenticationHelper().signOut().then(
                (_) => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (contex) => Login()),
                ),
              );
        },
        child: Icon(Icons.logout, color: Colors.black),
        tooltip: 'Logout',
      ),

      // floatingActionButton: SpeedDial(
      //   icon: Icons.arrow_circle_right_sharp,
      //   backgroundColor: Colors.indigo[900],
      //   children: [
      //     SpeedDialChild(
      //       child: Icon(
      //         Icons.newspaper,
      //         color: Colors.black,
      //       ),
      //       label: 'List',
      //       backgroundColor: Colors.green,
      //       onTap: () {
      //         AuthenticationHelper().signOut().then(
      //               (_) => Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(builder: (contex) => Login()),
      //           ),
      //         );
      //       },
      //     ),
      //     SpeedDialChild(
      //       child: Icon(
      //         Icons.logout,
      //         color: Colors.black,
      //       ),
      //       label: 'Logout',
      //       backgroundColor: Colors.orange,
      //       onTap: () {
      //         AuthenticationHelper().signOut().then(
      //               (_) => Navigator.pushReplacement(
      //                 context,
      //                 MaterialPageRoute(builder: (contex) => Login()),
      //               ),
      //             );
      //       },
      //     ),
      //   ],
      // ),

      bottomNavigationBar: Container(
        height: 80.0,
        child: BottomAppBar(
          color: Colors.indigo[500],
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Copyright by PR1MA 2023',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          elevation: 40.0,
        ),
      ),
    );
  }
}
