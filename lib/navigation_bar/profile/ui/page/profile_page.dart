import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../login/login.dart';
import '../../bloc/profile_bloc.dart';
import '../../model/profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileBloc profileBloc;
  Profile? profile;
  String userName = "";
  @override
  void initState() {
    profileBloc = ProfileBloc();
    profileBloc.add(FetchedProfileEvent());
    _loadUserName();
    super.initState();
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedUserName = prefs.getString("userName") ?? "";
    setState(() {
      userName = storedUserName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: profileBloc,
        builder: (context, state) {
          if (state is LoadingProfileState) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if (state is LoadedProfileState) {
            profile = state.profile;

            return buildBody();
          }
          if (state is FailureProfileState) {
            return Center(
              child: Text("Error"),
            );
          }
          return Container();
        },
      ),
    );
  }

  final user = FirebaseAuth.instance.currentUser!;
  Widget buildBody() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Имя пользователя: ${userName}',
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Lottie.asset('assets/profile.json'),
                SizedBox(height: 16),
                Text(
                  '${profile!.name}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Имя пользователя: ${userName}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Email: ${profile!.email}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Sign in as: ' + user.email!,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Телефон: ${profile!.phone}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Веб-сайт: ${profile!.website}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                fixedSize: Size(180, 50),
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                // if (user == null) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => LogInPage()));
                // }
              },
              child: Text(
                'Выйти',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
