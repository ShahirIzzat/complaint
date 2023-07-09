import 'package:flutter/material.dart';



class List extends StatelessWidget {
  const List({Key? key}) : super(key: key);

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
