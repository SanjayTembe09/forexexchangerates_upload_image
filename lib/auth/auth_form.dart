import 'package:flutter/material.dart';
import 'package:myapp/screens/image_text_extraction.dart';
//import 'package:myapp/screens/image_upload_screen_galary.dart';
//import 'package:myapp/screens/image_upload_screen_prev.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState(); 

}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true; 

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController(); 


  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Implement login or registration logic here
      if (_isLogin) {
        // Login logic
        // Assuming successful login
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageTextExtractor(),
        ),
      );
        print('Login with email: ${_emailController.text} and password: ${_passwordController.text}');
      } else {
        // Registration logic
        print('Register with email: ${_emailController.text}, password: ${_passwordController.text}, and username: ${_usernameController.text}');
      }
    }
  }

  void _toggleMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 500, // Adjust the width as needed
        child: Card(
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child:
 Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: const ValueKey('email'),
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration( 

                    labelText: 'Email address',
                  ),
                  validator: (value) {
                    if 
 (value!.isEmpty || !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value)) {
                      return 'Please enter a valid email.';
                    }
                    return null;
                  },
                  onSaved: (value) 
 {
                    // Handle saved email value
                  },
                ),
                TextFormField(
                  key: const ValueKey('password'),
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.length 
 < 6) {
                      return 'Password must be at least 6 characters long.';
                    }
                    return null; 

                  },
                  onSaved: (value) {
                    // Handle saved password value
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: const ValueKey('username'),
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                    validator: 
 (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return 'Username must be at least 4 characters long.';
                      }
                      return null;
                    },
                    onSaved: (value) 
 {
                      // Handle saved username value
                    },
                  ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(_isLogin ? 'Login' : 'Signup'),
                ),
                TextButton(
                  onPressed: _toggleMode,
                  child: Text(_isLogin ? 'Don\'t have an account? Sign up' : 'Already have an account? Login'),
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