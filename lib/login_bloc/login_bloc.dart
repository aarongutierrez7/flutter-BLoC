import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../LoginLogic.dart';
import './bloc.dart';
import 'login_bloc_state.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  final LoginLogic logic;

  LoginBloc({@required this.logic}) : super(null);

  @override
  LoginBlocState get initialState => InitialLoginBlocState();

  @override
  Stream<LoginBlocState> mapEventToState(LoginBlocEvent event) async* {
    if (event is DoLoginEvent) {
      yield* _doLogin(event);
    }
  }

  Stream<LoginBlocState> _doLogin(DoLoginEvent event) async* {
    yield LogginInBlocState();

    try {
      var token = await logic.login(event.email, event.password);
      yield LoggedInBlocState(token);
    } on LoginException {
      yield ErrorBlocState("Error en el login");
    }
  }
}
