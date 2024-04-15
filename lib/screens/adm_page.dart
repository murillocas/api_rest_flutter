
import 'package:flutter/material.dart';

import 'package:api_rest_flutter/models/item.dart';
import 'package:api_rest_flutter/services/api_service.dart';

import 'package:api_rest_flutter/utils/sec_storage.dart';


class AdmPage extends StatefulWidget {
  const AdmPage({super.key});

  @override
  State<AdmPage> createState() => _AdmPageState();
}

class _AdmPageState extends State<AdmPage> {

  List<Item>? items;
  var isLoaded = false;

   @override
  void initState() {
    super.initState();
    verifica_auth();
  }
  
  Future<void> verifica_auth() async {
    bool isAuthenticated = await SecureStorage().verifySecureData("apikey");
    if (!isAuthenticated) {
      Navigator.pushReplacementNamed(context, "/login");
    } else {
    // Autenticado, então pode prosseguir
      getData();
    }
  }


  getData() async {
    items = await RemoteService().getItems();
    print("get data foi chamado");
   
    if (items != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }
  test(){

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('página de administração'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'ir para a página home',
            onPressed: () {
             Navigator.pushNamed(context, "/");
            },
          ),

        ],
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
         
          var msg =  await Navigator.pushNamed(context, "/edit",arguments:{ "create": true});
                   print(msg);
                   if(msg == "atualizar"){
                    getData();
                   }
        },
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
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
              padding: const EdgeInsets.all(0.8),
              itemCount: items?.length,
              itemBuilder: (context, index) {
                final item = items![index];
                return ListTile(
                  title: Text(item.nameitem),
                  onTap: () async {
                   var msg = await Navigator.pushNamed(context, "/edit", arguments:{ 'item': item, "create": false} );
                   print(msg);
                   if(msg == "atualizar"){
                    getData();
                   }
                  },
                  // Você pode adicionar mais informações do item aqui, se necessário
                );
              },
            ),
            
          ),
        

         
        ),
      ),
    );
  }
}