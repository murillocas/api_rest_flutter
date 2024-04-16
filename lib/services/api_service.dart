import 'package:api_rest_flutter/models/item.dart';
import 'package:api_rest_flutter/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import "package:http/http.dart" as http;

import 'package:api_rest_flutter/utils/utils.dart' as utils; 
import 'package:api_rest_flutter/utils/sec_storage.dart';
import 'package:api_rest_flutter/models/item.dart';


class RemoteService{
  Future<List<Item>?> getItems() async {
    var client = http.Client();

    var uri = Uri.parse( "${utils.apiurlbase}/comprador/allitems");
    var response = await client.get(uri);
    
    if(response.statusCode ==200){
      var json = response.body;
      //print(json);
      return itemFromJson(json);
    }
  }

  Future<bool> login_validate(String email, String senha) async {



    print(email + " " + senha );
    var client = http.Client();
    var uri = Uri.parse('${utils.apiurlbase}/login');
   

    var response = await client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
          'email': email,
          'senha': senha,
        }),
      );
    var jsonData = json.decode(response.body);
    var token = jsonData['token'];

    if(response.statusCode ==200){
      await SecureStorage().writeSecureData("apikey", token);
      print(token);
      return true;

    }else{

      return false;

    }
  }


  Future<bool> updateItems(Item item) async {

    var client = http.Client();
    var uri = Uri.parse('${utils.apiurlbase}/vendedor/updateitem?id=${item.id}');
    String token = await SecureStorage().readSecureData("apikey");

    var response = await client.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$token'},
      body: json.encode(item.toJson()),
      );

    var jsonData = json.decode(response.body);
   //var token = jsonData['token'];
    print(response.statusCode);
    print(jsonData);

    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }

  }

  Future<bool> deletItems(Item item) async {

    var client = http.Client();
    var uri = Uri.parse('${utils.apiurlbase}/vendedor/deleteItem?id=${item.id}');

    String token = await SecureStorage().readSecureData("apikey");

    var response = await client.delete(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$token'},
      );

    var jsonData = json.decode(response.body);

    print(response.statusCode);
    print(jsonData);

    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
    
  }

  Future<bool> createItems(Item item) async {

    var client = http.Client();
    var uri = Uri.parse('${utils.apiurlbase}/vendedor/createItem');

    String token = await SecureStorage().readSecureData("apikey");
    print("criar no service");

    var response = await client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$token'
        },
      body: json.encode(item.toJson())
      );

    var jsonData = json.decode(response.body);

    print(response.statusCode);
    print(jsonData);

    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
    
  }





}