import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_1_todo_app/presentation/widgets/button_primary_widget.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_1_todo_app/presentation/widgets/text_field_widget.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_2_auth_api/bloc/auth_bloc.dart';
import 'package:flutter_tes_mobile_kalanara_group/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  void _navigateToHomePage() {
    Navigator.pushReplacementNamed(context, '/home_auth');
  }

  // check token
  void _checkToken() {
    context.read<AuthBloc>().add(AuthCheckEvent());
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            _navigateToHomePage();
          } else if (state is AuthError) {
            Utils.showToastError(context, state.message);
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            SizedBox(height: 18.0),
            const Center(
              child: Text(
                'Login',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 40.0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFieldWidget(
                    controller: _usernameController,
                    label: 'Username',
                    focusNode: _usernameFocusNode,
                    hintText: 'Enter your username',
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFieldWidget(
                    controller: _passwordController,
                    label: 'Password',
                    focusNode: _passwordFocusNode,
                    hintText: 'Enter your password',
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ButtonPrimaryWidget(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const CupertinoActivityIndicator(
                            color: Colors.white,
                          );
                        }
                        return const Text('Login');
                      },
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle login logic here
                        context.read<AuthBloc>().add(
                          AuthLoginEvent(
                            _usernameController.text,
                            _passwordController.text,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
