import 'package:api_rest_flutter/utils/sec_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:api_rest_flutter/services/api_service.dart';
import 'package:api_rest_flutter/models/item.dart';




class EditItemPage extends StatefulWidget {
  const EditItemPage({super.key});

  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  final _formKey = GlobalKey<FormState>();


  TextEditingController namecontroller = TextEditingController();
  TextEditingController precoController = TextEditingController();
  TextEditingController qtdController = TextEditingController();
  TextEditingController descricaocontroller = TextEditingController();
  TextEditingController publishedcontroller = TextEditingController();
  TextEditingController categorycontroller = TextEditingController();

  Item? item;
   bool isLoaded = false;
   bool criacao = false;

 @override
   initState()  {
    super.initState();
    verifica_auth();

    //redirecionar();
}
  Future<void> verifica_auth() async {
    bool isAuthenticated = await SecureStorage().verifySecureData("apikey");
    if (!isAuthenticated) {
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      redirecionar();
    }
  }

redirecionar (){
    Future.delayed(const Duration(seconds: 1), () {
      if (!isLoaded) {
        Navigator.pushReplacementNamed(context, "/adm");
      }
    });
}

@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  
  }

  Future<bool> deletaritem(Item item) async{
    return await RemoteService().deletItems(item);
  
  }
  Future<bool> updateitem(Item item) async{
    return await RemoteService().updateItems(item);
  
  }
  Future<bool> createitem(Item item) async{
    print("metodo create edit");
    return await RemoteService().createItems(item);
  
  }



  @override
  Widget build(BuildContext context) {
 

  if(!(ModalRoute.of(context)?.settings.arguments == null)){
      print(ModalRoute.of(context)?.settings.arguments);

      final Map<String, dynamic> args =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      print(args);


      if (!args['create']) {
        print("não e para criar");
        isLoaded = true;
        item = args['item'] as Item;
        namecontroller.text = item!.nameitem.toString();
        precoController.text = item!.price.toString();
        qtdController.text = item!.qtd.toString();
        descricaocontroller.text = item!.descricao.toString();
        publishedcontroller.text = item!.published.toString();
        categorycontroller.text = item!.category.toString();
      }else{
          print(" e para criar");
          item = Item(id: 0, nameitem: "");
          isLoaded = true;
          criacao = true;
      }
      
  }else{

  }

 

    return   Scaffold(
      appBar: AppBar(
        title: Text("atualização"),
      ),
      body: Center(
        child:  Visibility(
          visible: isLoaded,
          replacement: const CircularProgressIndicator(),
          child: SizedBox.square( 
          dimension: 600,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: namecontroller,
                        decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "nome do item"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: precoController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "preço"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: qtdController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "quantidade"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: descricaocontroller,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "descrição"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: categorycontroller,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "categoria"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: !criacao,
                          child: Expanded(
                            child: 
                              Padding(
                               
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                                child: Center(
                                  child: ElevatedButton(
                            
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        print("forms preenchido ");
                                        atualizarobjeto();
                                      if (await updateitem(item!)) {
                                        print("forms enviado para atualizar ");
                          
                                        Navigator.pop(context,"atualizar");
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('O item não foi atualizado')),
                                      );
                                      }
                                        // Navigate the user to the Home page
                                        
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Please fill input')),
                                        );
                                      }
                                    },
                                    child: const Text('atualizar'),
                                  ),
                                ),
                              ),
                            
                          ),
                        ),Visibility(
                          visible: !criacao,
                          child: Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      
                                      
                                      if (await deletaritem(item!)) {
                                        Navigator.pop(context,"atualizar");
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('O item não foi deletado')),
                                      );
                                      }
                                      // Navigate the user to the Home page
                                      
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Please fill input')),
                                      );
                                    }
                                  },
                                  child: const Text('deletar'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: criacao,
                          child: Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    print("click no criar");
                                    if (_formKey.currentState!.validate()) {
                                       print("click no criar no validate");
                                       print(item);
                                        atualizarobjeto();

                                      
                                      if (await createitem(item!)) {
                                        Navigator.pop(context,"atualizar");
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('O item não foi criado')),
                                      );
                                      }
                                      // Navigate the user to the Home page
                                      
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Please fill input')),
                                      );
                                    }
                                  },
                                  child: const Text('criar'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  void atualizarobjeto() {

      item?.nameitem = namecontroller.text;
      item?.price = precoController.text;
      item?.qtd = int.tryParse( qtdController.text);
      item?.descricao = descricaocontroller.text;
      item?.category = categorycontroller.text;

  }


}