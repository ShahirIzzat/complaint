import 'package:flutter/material.dart';

import 'package:complaint/authentication.dart';
import 'package:complaint/login.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';

class CRUDEoperation extends StatefulWidget {
  const CRUDEoperation({super.key});

  @override
  State<CRUDEoperation> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CRUDEoperation>
    with SingleTickerProviderStateMixin {
  // text field controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _snController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  final CollectionReference _items =
      FirebaseFirestore.instance.collection('items');

  String searchText = '';

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  // for create operation
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Create your message",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Topic'),
                ),
                TextField(
                  controller: _snController,
                  decoration: const InputDecoration(labelText: 'Subject'),
                ),
                TextField(
                  controller: _numberController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String name = _nameController.text;
                      final String sn = _snController.text;
                      final String number = _numberController.text;
                      if (name!.isEmpty || number!.isEmpty || sn!.isEmpty) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please complete a form"),
                          ),
                        );
                      } else {
                        await _items
                            .add({"name": name, "number": number, "sn": sn});
                        _nameController.text = '';
                        _snController.text = '';
                        _numberController.text = '';

                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo[900], // Background color
                    ),
                    child: const Text("Submit"))
              ],
            ),
          );
        });
  }

  // for Update operation
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _snController.text = documentSnapshot['sn'].toString();
      _numberController.text = documentSnapshot['number'].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Update your message",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Topic'),
                ),
                TextField(
                  // keyboardType: TextInputType.number,
                  controller: _snController,
                  decoration: const InputDecoration(labelText: 'Subject'),
                ),
                TextField(
                  // keyboardType: TextInputType.number,
                  controller: _numberController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String sn = _snController.text;
                    final String number = _numberController.text;
                    if (name != null && number != null && sn != null) {
                      await _items
                          .doc(documentSnapshot!.id)
                          .update({"name": name, "number": number, "sn": sn});
                      _nameController.text = '';
                      _snController.text = '';
                      _numberController.text = '';

                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[900], // Background color
                  ),
                  child: const Text("Update"),
                ),
              ],
            ),
          );
        });
  }

  // for delete operation
  Future<void> _delete(String productID) async {
    await _items.doc(productID).delete();

    // for snackBar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("You have successfully deleted a message"),
      ),
    );
  }

  // for search
  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
    });
  }

  // // show message

  bool isSearchClicked = false;

  @override
  Widget build(BuildContext context) {
    var height, width;

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/background.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          title: isSearchClicked
              ? Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                        hintText: 'Search..'),
                  ),
                )
              : const Text('PERBADANAN PR1MA MALAYSIA'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isSearchClicked = !isSearchClicked;
                  });
                },
                icon: Icon(isSearchClicked ? Icons.close : Icons.search))
          ],
        ),
        body: StreamBuilder(
          stream: _items.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              final List<DocumentSnapshot> items = streamSnapshot.data!.docs
                  .where((doc) => doc['name'].toLowerCase().contains(
                        searchText.toLowerCase(),
                      ))
                  .toList();
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot = items[index];

                  return GestureDetector(
                    onTap: () {
                      String displayText1 = documentSnapshot['name'].toString();
                      String displayText2 = documentSnapshot['sn'].toString();
                      String displayText3 =
                          documentSnapshot['number'].toString();

                      Future<void> showMyDialog(
                          BuildContext context,
                          String displayText1,
                          String displayText2,
                          String displayText3) {
                        return showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Center(
                              child: Container(
                                padding: new EdgeInsets.all(100.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Colors.yellowAccent[100],
                                  elevation: 10.0,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        title: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10.0, 10.0, 10.0, 0),
                                          child: Text(
                                            displayText1,
                                            style: TextStyle(fontSize: 25.0),
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10.0, 0, 10.0, 20.0),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 25.0,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 1.0),
                                                  child: Text(
                                                    displayText3,
                                                    style: TextStyle(
                                                        fontSize: 15.0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }

                      showMyDialog(
                          context, displayText1, displayText2, displayText3);
                    },
                    child: Card(
                      color: Colors.yellowAccent[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                          documentSnapshot['name'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        subtitle: Text(documentSnapshot['sn'].toString()),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                  color: Colors.black,
                                  onPressed: () => _update(documentSnapshot),
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                  color: Colors.red,
                                  onPressed: () => _delete(documentSnapshot.id),
                                  icon: const Icon(Icons.delete)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),

        //Init Floating Action Bubble
        floatingActionButton: FloatingActionBubble(
          // Menu items
          items: <Bubble>[
            // Floating action menu item
            Bubble(
              title: "Message",
              iconColor: Colors.black,
              bubbleColor: Colors.yellow.shade200,
              icon: Icons.email,
              titleStyle: TextStyle(fontSize: 16, color: Colors.black),
              onPress: () {
                _animationController.reverse();
                _create();
              },
            ),

            //Floating action menu item
            Bubble(
              title: "Home",
              iconColor: Colors.black,
              bubbleColor: Colors.yellow.shade200,
              icon: Icons.home,
              titleStyle: TextStyle(fontSize: 16, color: Colors.black),
              onPress: () {
                AuthenticationHelper().signOut().then(
                      (_) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (contex) => Login()),
                      ),
                    );
                _animationController.reverse();
              },
            ),
          ],

          // animation controller
          animation: _animation,

          // On pressed change animation state
          onPress: () => _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward(),

          // Floating Action button Icon color
          iconColor: Colors.white,

          // Flaoting Action button Icon
          iconData: Icons.add_alarm_sharp,
          backGroundColor: Colors.indigo.shade900,
        ),
      ),
    );
  }
}
