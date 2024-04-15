import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:api_rest_flutter/models/item.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';



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

 
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  
  }




  @override
  Widget build(BuildContext context) {
 final item = ModalRoute.of(context)!.settings.arguments as Item;

 namecontroller.text = item.nameitem.toString();
 precoController.text = item.price.toString();
 qtdController.text = item.qtd.toString();
 descricaocontroller.text = item.descricao.toString();
 publishedcontroller.text = item.published.toString();
 categorycontroller.text = item.category.toString();

    return   Scaffold(
      appBar: AppBar(
        title: Text("atualização"),
      ),
      body: Center(
        child:  SizedBox.square( 
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
                      Expanded(
                        child: 
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    
                                    
                                    // Navigate the user to the Home page
                                    
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Please fill input')),
                                    );
                                  }
                                },
                                child: const Text('Submit'),
                              ),
                            ),
                          ),
                        
                      ),Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  
                                  
                                  // Navigate the user to the Home page
                                  
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please fill input')),
                                  );
                                }
                              },
                              child: const Text('delete'),
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
    );
  }
}