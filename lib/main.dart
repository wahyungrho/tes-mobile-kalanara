import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tes_mobile_kalanara_group/main_page.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_1_todo_app/domain/repositories/todo_repository.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_1_todo_app/logic/todo_bloc/todo_bloc.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_1_todo_app/presentation/pages/todo_page.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_2_auth_api/bloc/auth_bloc.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_2_auth_api/data/shared_preference_service.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_2_auth_api/domain/auth_repositories.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_2_auth_api/presentation/pages/home_page.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_2_auth_api/presentation/pages/login_page.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_3_fetch_data_api/bloc/post_bloc.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_3_fetch_data_api/domain/repositories/post_repository.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_3_fetch_data_api/presentation/pages/post_page.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_4_responsive_ui_navigation/presentation/pages/home_product_page.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_5_debuging_code_review/pages/home_debugging_review_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize SharedPreferences
  await SharedPreferenceService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TodoBloc(TodoRepository())),
        BlocProvider(create: (context) => AuthBloc(AuthRepositories())),
        BlocProvider(create: (context) => PostBloc(PostRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Tes Kalanara Group',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: MainPage(),
        routes: {
          '/main': (context) => MainPage(),
          '/todo': (context) => TodoPage(),
          '/login_auth': (context) => LoginPage(),
          '/home_auth': (context) => HomePage(),
          '/post': (context) => PostPage(),
          '/home_product': (context) => HomeProductPage(),
          '/home_debug': (context) => const HomeDebuggingReviewPage(),
        },
      ),
    );
  }
}
