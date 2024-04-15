
import 'package:flutter/material.dart';

import 'package:api_rest_flutter/models/item.dart';
import 'package:api_rest_flutter/services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Item>? items;
  var isLoaded = false;

   @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    items = await RemoteService().getItems();
    print( items!.length);
    if (items != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem vindo'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'realizar o login',
            onPressed: () {
             Navigator.pushNamed(context, "/login");
            },
          ),

        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: Container(
            height: 500,
            width: 500,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[300],
                    ),
            alignment: Alignment.center,
            child: ListView.builder(
              itemCount: items?.length,
              itemBuilder: (context, index) {
                final item = items![index];
                return ListTile(
                  title: Text(item.nameitem),


                );
              },
            ),
          ),
         
        ),
      ),
    );
  }
}