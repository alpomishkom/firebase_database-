
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../contact/model/model.dart';
import '../contact/service/service.dart';

class MyDiyalog extends StatefulWidget {
  const MyDiyalog({super.key});

  @override
  State<MyDiyalog> createState() => _MyDiyalogState();
}

class _MyDiyalogState extends State<MyDiyalog> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> list = [];
  Future<void> creadt(Contact contact) async {
    await Service1.serviceSV(collectionPath: "contact", data: contact.toJson());
  }

  Future<void> getAll() async {
    list = await Service1.GET(collectionPath: "contact");
    setState(() {});
  }

  Future<void> delete(
      {required String collectionPath, required String documentId}) async {
    await Service1.DELET(
        collectionPath: collectionPath, documentId: documentId);
  }

  @override
  Widget build(BuildContext context) {
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
          onPressed: () {
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
              Navigator.pop(context);
              setState(() {
                getAll();
              });
            }
          },
          child: Text("SAVE"),
        ),
      ],
    );
  }
}
