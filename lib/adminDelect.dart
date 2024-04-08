import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

class Delectpage extends StatefulWidget {
  const Delectpage({Key? key}) : super(key: key);

  @override
  State<Delectpage> createState() => _DelectpageState();
}

class _DelectpageState extends State<Delectpage> {
  late Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> _combinedStream;

  @override
  void initState() {
    super.initState();
    _combinedStream = mergeStreams();
  }

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> mergeStreams() {
    final itemsStream = FirebaseFirestore.instance.collection("items").snapshots();
    final kidsStream = FirebaseFirestore.instance.collection("kids").snapshots();
    final premiumStream = FirebaseFirestore.instance.collection("premium").snapshots();
    final weddingCakeStream = FirebaseFirestore.instance.collection("weddingcake").snapshots();

    return Rx.combineLatest4(
      itemsStream,
      kidsStream,
      premiumStream,
      weddingCakeStream,
          (QuerySnapshot<Map<String, dynamic>> items, QuerySnapshot<Map<String, dynamic>> kids, QuerySnapshot<Map<String, dynamic>> premium, QuerySnapshot<Map<String, dynamic>> weddingcake) {
        final List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs = [];
        allDocs.addAll(items.docs);
        allDocs.addAll(kids.docs);
        allDocs.addAll(premium.docs);
        allDocs.addAll(weddingcake.docs);
        return allDocs;
      },
    );
  }

  remove({required String docid, required String collection}) async {
    await FirebaseFirestore.instance.collection(collection).doc(docid).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("cakes"),
      ),
      body: StreamBuilder(
        stream: _combinedStream,
        builder: (BuildContext context, AsyncSnapshot<List<QueryDocumentSnapshot<Map<String, dynamic>>>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                final collectionName = item.reference.parent?.id; // Extracting collection name dynamically
                return ListTile(
                  leading: SizedBox(
                    width: 60, // Adjust the width as per your requirement
                    child: Image.network(
                      item["image"],
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(item["name"]),
                  subtitle: Text(item["price"].toString()),
                  trailing: IconButton(
                    onPressed: () {
                      remove(docid: item.id, collection: collectionName!); // Passing the collection name
                      Fluttertoast.showToast(msg: "deleted");
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}


