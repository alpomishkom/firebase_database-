import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contakt_ui/pages/contact/model/model.dart';
import 'package:contakt_ui/pages/contact/service/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  bool isLoading = true;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> list = [];

  Future<void> creadt(Contact contact) async {
    await Service1.serviceSV(collectionPath: "contact", data: contact.toJson());
  }

  //
  // Future<void> cr(Contact contact) async {
  //   await Service1.creade("user", contact.toJson());
  // }

  Future<void> getAll() async {
    list = await Service1.GET(collectionPath: "contact");
    isLoading = false;
    setState(() {});
  }

  Future<void> delete(
      {required String collectionPath, required String documentId}) async {
    await Service1.DELET(
        collectionPath: collectionPath, documentId: documentId);
  }

  @override
  void initState() {
    getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text("Contact"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.876,
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (_) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 24),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            list[index].data()['address'],
                                            style: TextStyle(fontSize: 30),
                                          ),
                                          Text(list[index].data()['name'],
                                              style: TextStyle(fontSize: 30)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        list[index].data()['phoneNumber'],
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Card(
                            color: Colors.amber,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: CupertinoColors.white,
                                radius: 24,
                                child: Icon(CupertinoIcons.person_2),
                              ),
                              title: Text(
                                list[index].data()['name'],
                                style: TextStyle(color: CupertinoColors.white),
                              ),
                              subtitle: Text(
                                list[index].data()['phoneNumber'],
                                style: TextStyle(color: CupertinoColors.white),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.amber,
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextField(
                                                    controller: Service1.id,
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      hintText: "id",
                                                      border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(12),
                                                          borderSide: BorderSide.none),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 16,
                                                  ),
                                                  TextField(
                                                    controller: Service1.name,
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      hintText: "name",
                                                      border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(12),
                                                          borderSide: BorderSide.none),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 16,
                                                  ),
                                                  TextField(
                                                    controller: Service1.address,
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      hintText: "address",
                                                      border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(12),
                                                          borderSide: BorderSide.none),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 16,
                                                  ),
                                                  TextField(
                                                    controller: Service1.phoneNumber,
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      hintText: "phoneNumber",
                                                      border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(12),
                                                          borderSide: BorderSide.none),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 16,
                                                  ),
                                                  TextField(
                                                    controller: Service1.company,
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      hintText: "company",
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(12),
                                                        borderSide: BorderSide.none,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("CLOSE"),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    var id = Service1.id.text;
                                                    var name = Service1.name.text;
                                                    var phoneNumber = Service1.phoneNumber.text;
                                                    var address = Service1.address.text;
                                                    var company = Service1.company.text;

                                                    if (id.isNotEmpty &&
                                                        name.isNotEmpty &&
                                                        phoneNumber.isNotEmpty &&
                                                        address.isNotEmpty &&
                                                        company.isNotEmpty) {
                                                      Service1.PUT(collectionPath: "contact", documentId: list[index].id, data:  Contact(
                                                        name: name,
                                                        phoneNumber: phoneNumber,
                                                        address: address,
                                                        company: company,
                                                        isFavorited: true,
                                                        id: id,
                                                      ).toJson());
                                                      Service1.id.clear();
                                                      Service1.name.clear();
                                                      Service1.phoneNumber.clear();
                                                      Service1.address.clear();
                                                      Service1.company.clear();
                                                      await getAll().then((value) {
                                                        setState(() {});
                                                      });
                                                      Navigator.pop(context);

                                                    }
                                                  },
                                                  child: Text("SAVE"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.refresh,
                                        color: CupertinoColors.white,
                                      )),
                                  IconButton(
                                    onPressed: () async {
                                      await delete(
                                          collectionPath: "contact",
                                          documentId: list[index].id);
                                      setState(
                                        () {
                                          getAll();
                                        },
                                      );
                                      debugPrint(list[index].id);
                                    },
                                    icon: Icon(
                                      CupertinoIcons.delete,
                                      color: CupertinoColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.amber,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: Service1.id,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "id",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: Service1.name,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: Service1.address,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "address",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: Service1.phoneNumber,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "phoneNumber",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: Service1.company,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "company",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("CLOSE"),
                  ),
                  TextButton(
                    onPressed: () async {
                      var id = Service1.id.text;
                      var name = Service1.name.text;
                      var phoneNumber = Service1.phoneNumber.text;
                      var address = Service1.address.text;
                      var company = Service1.company.text;

                      if (id.isNotEmpty &&
                          name.isNotEmpty &&
                          phoneNumber.isNotEmpty &&
                          address.isNotEmpty &&
                          company.isNotEmpty) {
                        creadt(
                          Contact(
                            name: name,
                            phoneNumber: phoneNumber,
                            address: address,
                            company: company,
                            isFavorited: true,
                            id: id,
                          ),
                        );
                        await getAll().then((value) {
                          setState(() {});
                        });
                        Navigator.pop(context);
                      }
                      Service1.id.clear();
                      Service1.name.clear();
                      Service1.phoneNumber.clear();
                      Service1.address.clear();
                      Service1.company.clear();
                    },
                    child: Text("SAVE"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(CupertinoIcons.add),
      ),
    );
  }
}
