import 'package:api_practice_app/bloc/user_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late UserBloc _userBloc;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _userBloc = UserBloc();
    _userBloc.add(GetUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textUser(String? textInfo) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          textInfo!,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BlocConsumer<UserBloc, UserState>(
          bloc: _userBloc,
          listener: (context, state) {
            if (state is UserErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UserLoadedState) {
              return Padding(
                padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          state.userModel.results.last.picture.large),
                      radius: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${state.userModel.results.last.name.title} '),
                          Text('${state.userModel.results.last.name.first} '),
                          Text(state.userModel.results.last.name.last),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.black),
                    TabBar(
                      unselectedLabelColor: Colors.purple,
                      labelColor: Colors.black,
                      tabs: const [
                        Tab(text: 'Main info'),
                        Tab(text: 'Location'),
                        Tab(text: 'Email'),
                      ],
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.label,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: TabBarView(
                        dragStartBehavior: DragStartBehavior.down,
                        controller: _tabController,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 15),
                                  const Text('Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  textUser('FirstName:'),
                                  textUser('LastName:'),
                                  textUser('Gender:'),
                                  textUser('DateOfBirth:'),
                                  textUser('Age:'),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SizedBox(height: 15),
                                  const Text('Value',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  textUser(
                                      state.userModel.results.first.name.first),
                                  textUser(
                                      state.userModel.results.first.name.last),
                                  textUser(
                                      state.userModel.results.first.gender),
                                  textUser(state
                                      .userModel.results.first.registered.date
                                      .toString()),
                                  textUser(state
                                      .userModel.results.first.registered.age
                                      .toString()),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 15),
                                  const Text('Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  textUser('Coutry:'),
                                  textUser('State:'),
                                  textUser('City:'),
                                  textUser('Street:'),
                                  textUser('PostCode:'),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SizedBox(height: 15),
                                  const Text('Value',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  textUser(state
                                      .userModel.results.first.location.country
                                      .toString()),
                                  textUser(state
                                      .userModel.results.first.location.state
                                      .toString()),
                                  textUser(state
                                      .userModel.results.first.location.city),
                                  textUser(state
                                      .userModel.results.first.location.street
                                      .toString()),
                                  textUser(state
                                      .userModel.results.first.location.postcode
                                      .toString()),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 15),
                                  const Text('Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  textUser('Email:'),
                                  textUser('UserName:'),
                                  textUser('Phone:'),
                                  textUser('Cell:'),
                                  textUser('Registered:'),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SizedBox(height: 15),
                                  const Text('Value',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  textUser(state.userModel.results.first.email
                                      .toString()),
                                  textUser(state
                                      .userModel.results.first.login.username
                                      .toString()),
                                  textUser(state.userModel.results.first.phone),
                                  textUser(state.userModel.results.first.cell),
                                  textUser(state.userModel.results.first
                                      .registered.hashCode
                                      .toString()),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.black),
                    const SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {
                        _userBloc.add(GetUserEvent());
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.cyan),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text(
                        'NEXT',
                        style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is UserErrorState) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    _userBloc.add(GetUserEvent());
                  },
                  child: const Text('Повторить'),
                ),
              );
            }
            return const Text('Error');
          },
        ),
      ),
    );
  }
}
