import 'dart:io';

import 'package:api_practice_app/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is GetUserEvent) {
        emit(UserLoadingState());
        try {
          var url = Uri.parse('https://randomuser.me/api/');
          var responce = await get(url);
          if (responce.statusCode == 200) {
            UserModel userModel = UserModel.fromRawJson(responce.body);
            emit(UserLoadedState(userModel: userModel));
          } else {
            emit(UserErrorState(error: 'Ошибка системы'));
          }
        } on SocketException catch (e) {
          emit(UserErrorState(error: 'Нет интернет соединения'));
        } catch (e) {
          emit(UserErrorState(error: e.toString()));
        }
      }
    });
  }
}
