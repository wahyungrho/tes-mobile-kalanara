import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_1_todo_app/presentation/widgets/button_primary_widget.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_2_auth_api/bloc/auth_bloc.dart';
import 'package:flutter_tes_mobile_kalanara_group/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Home Page !',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            Text(
              'You are logged in',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            ButtonPrimaryWidget(
              width: 200,
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthLogout) {
                    Navigator.pushReplacementNamed(context, '/login_auth');
                    Utils.showToastSuccess(context, 'Logout Success');
                  }
                },
                child: Text('Logout'),
              ),
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}
