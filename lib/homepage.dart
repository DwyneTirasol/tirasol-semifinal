import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List clientInformation = <dynamic>[];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var url = 'https://jsonplaceholder.typicode.com/users';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        clientInformation = convert.jsonDecode(response.body) as List<dynamic>;
      });
    }
  }

  void deleteData(var id) async {
    var url = 'https://jsonplaceholder.typicode.com/users';
    var response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      final filtered =
          clientInformation.where((element) => element['id'] != id).toList();
      setState(() {
        clientInformation = filtered;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hands On'),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: clientInformation.length,
            itemBuilder: (context, index) {
              return Dismissible(
                background: Container(
                  color: Colors.lime,
                  child: const Icon(Icons.delete),
                ),
                key: ValueKey<Map>(clientInformation[index]),
                onDismissed: (DismissDirection direction) {
                  deleteData(clientInformation[index]['id']);
                },
                child:Card(
                  child: ListTile(
                    title: Text(clientInformation[index]['name']),
                    subtitle: Text(clientInformation[index]['email']),
                  ),
                ),
              );
            }));
  }
}
