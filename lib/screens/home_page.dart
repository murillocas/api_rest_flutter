
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:api_rest_flutter/models/item.dart';
import 'package:api_rest_flutter/services/api_service.dart';
import 'package:flutter/widgets.dart';

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
      body: Center(
        child: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: Container(
            height: 500,
            width: MediaQuery.of(context).size.width / 1.2,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[300],
                    ),
            alignment: Alignment.center,
            child:
            
             ListView.builder(
              itemCount: items?.length,
              itemBuilder: (context, index) {
                final item = items![index];
                return Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),
                  decoration:  BoxDecoration(
                  
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children :[ 
                      Expanded(
                  
                        child: Text(item.nameitem.toString(),maxLines: 1,overflow: TextOverflow.ellipsis,)
                      ), 
                      Expanded(
                        child: Text('R\$${item.price}',maxLines: 1,overflow: TextOverflow.ellipsis,)
                      ),
                      Expanded(
                        child: Text('${item.price} unidades',maxLines: 1,overflow: TextOverflow.ellipsis,)
                        ),

                    ] 
                  ),
                );

                /*return ListTile(
                  title: Text(item.nameitem),


                );*/
              },
            ),
          ),
         
        ),
      ),
    );
  }
}