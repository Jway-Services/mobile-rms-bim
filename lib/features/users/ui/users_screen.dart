
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/error_widget.dart';
import '../../../components/offline_widget.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/enums/app_status.dart';
import '../../../core/dependencies/dependencies.dart';
import '../../../core/services/shared_pref_service.dart';
import '../../../repository/repository.dart';
import '../bloc/users_bloc/users_bloc.dart';
import 'components/user_item.dart';


class UsersScreen extends StatefulWidget {
  static Widget page() {

    SharedPrefService sharedPrefService=Dependencies.get<SharedPrefService>();
    Repository repository=Dependencies.get<Repository>();

    return BlocProvider<UsersBloc>(
      create: (context) => UsersBloc(repository: repository,sharedPrefService: sharedPrefService),
      child: UsersScreen(),
    );
  }

  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUsers();
  }


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;


    return Scaffold(
        extendBodyBehindAppBar: true,

        body: Column(
          children: [
            BlocListener<UsersBloc,UsersState>(
                listener: _usersListenner,
              child: SizedBox(),
            ),
            Expanded(
                child:BlocBuilder<UsersBloc,UsersState>(
                  builder: (context,state){
                    if(state.fetchUsersStatus==AppStatus.loading){
                      return ListView(
                        children: List.generate(4, (index) => UserItem(isLoading: true,)),
                      );
                    }else if(state.fetchUsersStatus==AppStatus.success){
                      return ListView(
                        children: state.users!.map((user) => UserItem(user: user,)).toList(),
                      );
                    }else if(state.fetchUsersStatus==AppStatus.error){
                      if(state.isOffline ?? false){
                        return OfflineWidget(action: AppStrings.tryAgain, msg: AppStrings.checkConnectivity,actionCLick: fetchUsers,);
                      }else{
                        return MyErrorWidget(error: state.error ?? "Error", action: AppStrings.tryAgain,actionCLick: fetchUsers,);
                      }
                    }
                    return SizedBox();
                  },
                )
            )
          ],
        )
    );
  }

  void _usersListenner(BuildContext context, UsersState state) {

  }

  void fetchUsers() {
    BlocProvider.of<UsersBloc>(context).add(FetchUsers());
  }
}
