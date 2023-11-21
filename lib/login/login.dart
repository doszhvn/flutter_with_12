import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:practice_8_9/login/repository/auth_repository.dart';
import '../navigation_bar/navigation_bar.dart';
import 'bloc/auth_bloc.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _hidePass = true;

    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Center(
                child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
              SizedBox(
                  height: 150,
                  width: 200,
                  child: Lottie.asset('assets/welcome.json')),
              Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ThemeData().colorScheme.copyWith(
                          primary: Colors.black,
                        ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: (BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50))),
                    height: 300,
                    width: 380,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            hintText: "Напиши свою почту",
                            prefixIcon: Icon(Icons.mail),
                            // ignore: unnecessary_const
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                            ),
                            // ignore: unnecessary_const
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          // validator: _validateEmail,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: "Пароль",
                            hintText: "Напиши свой пароль",
                            suffixIcon: IconButton(
                              icon:
                                  // ignore: dead_code
                                  Icon(_hidePass
                                      ? Icons.visibility
                                      // ignore: dead_code
                                      : Icons.visibility_off),
                              onPressed: () {
                                _hidePass = !_hidePass;
                              },
                            ),
                            prefixIcon: const Icon(Icons.security),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                            ),
                            // ignore: unnecessary_const
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                            ),
                          ),
                        ),
                        BlocProvider(
                          create: (context) => LoginBloc(
                            AuthRepository(),
                          ),
                          child: Center(
                              child: BlocConsumer<LoginBloc, LoginState>(
                                  listener: (context, state) {
                            if (state is LoginSuccess) {
                              final snackBar = SnackBar(
                                content: Container(
                                  color: Colors.white,
                                  child: Text(
                                    "Вы авторизованы успешно",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontFamily: 'Inter',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          NavigationnBar()));
                            }
                            if (state is LoginError) {
                              final snackBar = SnackBar(
                                content: Text(
                                  state.error,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'Inter',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }, builder: (context, state) {
                            if (state is LoginLoading) {
                              return const Center(
                                child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                      strokeWidth: 4,
                                    )),
                              );
                            }
                            return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  fixedSize: Size(180, 50),
                                ),
                                onPressed: () async {
                                  BlocProvider.of<LoginBloc>(context).add(
                                      LoginButtonPressed(_emailController.text,
                                          _passwordController.text));
                                },
                                child: const Text(
                                  'Войти',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Inter',
                                      fontSize: 20),
                                ));
                          })),
                        ),
                      ],
                    ),
                  )),
              SizedBox(),
            ])))));
  }
}
