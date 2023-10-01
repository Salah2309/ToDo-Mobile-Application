import 'package:flutter/material.dart';
import 'home.dart';

class Login extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white70,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {_login(context);},
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
    
  //Add API function here!
    
  void _login(BuildContext context) {
    // Perform login logic here
    String email = _emailController.text;
    String password = _passwordController.text;

    // You can add your login validation and authentication logic here
    // For simplicity, we'll just print the entered email and password for now.
    print("Email: $email");
    print("Password: $password");


    // Navigate to the next screen upon successful login
    while(Navigator.of(context).canPop()){
      Navigator.pop(context);
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(
       builder: (context) => const Home(),
    ));
  }
  AppBar _appbar(){
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Login'),
    );
  }
}
