import 'package:flutter/material.dart';
import 'package:api_rest_flutter/services/api_service.dart';
import 'package:api_rest_flutter/utils/sec_storage.dart';


class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  trylogin() async {
    var results = await RemoteService().login_validate(emailController.text, passwordController.text);
    print(results);
    // resultado e booleano
    return results;
  }
  
  

Future<void> verifica_auth() async {
    bool isAuthenticated = await SecureStorage().verifySecureData("apikey");
    if (isAuthenticated) {
      Future.delayed(const Duration(seconds: 1 ), () {
        Navigator.pushReplacementNamed(context, "/adm");

      });
    } 
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    verifica_auth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("login"),
      ),
      body: Form(
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
                  controller: emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Email"),
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
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Password"),
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
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {

                        
                        // Navigate the user to the Home page
                        if (await trylogin()) {
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                      email: emailController.text,
                                    )),
                          );*/
                          Navigator.pushReplacementNamed(context, "/adm");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('login ou senha invalida')),
                          );
                        }

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
            ],
          ),
        ),
      ),
    );
  }
}
