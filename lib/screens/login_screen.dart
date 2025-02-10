import 'package:humhum/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:clay_containers/clay_containers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> _loginWithEmail() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const MainScreen();
      }));
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signupWithEmail() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const MainScreen();
      }));
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const MainScreen();
      }));
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login',
            style: TextStyle(
              color: Colors.orange,
            )),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 80,
                            child: Image.asset('assets/images/humhum_logo.png'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    ClayContainer(
                        emboss: true,
                        borderRadius: 25,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.orange),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.orange,
                                ),
                                border: InputBorder.none),
                            cursorColor: Colors.orange,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        )),
                    // 空白
                    const SizedBox(height: 16),
                    ClayContainer(
                        emboss: true,
                        borderRadius: 25,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                                labelText: 'Password',
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.orange),
                                labelStyle: TextStyle(color: Colors.orange),
                                border: InputBorder.none),
                            obscureText: true,
                          ),
                        )),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: _loginWithEmail,
                      child: const Text('Login',
                          style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: _signupWithEmail,
                      child: const Text('Sign Up',
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('OR'),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _loginWithGoogle,
                      icon: Image.asset(
                        'assets/images/google.png',
                        height: 24,
                        width: 24,
                      ),
                      label: const Text('Login with Google'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
