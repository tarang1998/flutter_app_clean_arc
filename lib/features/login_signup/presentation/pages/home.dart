
import 'package:brew_app_clean_arc/features/brew/presentation/bloc/bloc.dart';
import 'package:brew_app_clean_arc/features/brew/presentation/widgets/BrewList.dart';
import 'package:brew_app_clean_arc/features/brew/presentation/widgets/SettingsForm.dart';
import 'package:brew_app_clean_arc/features/login_signup/presentation/bloc/bloc_authenticate/bloc.dart';
import 'package:brew_app_clean_arc/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {

  final String name;
  final String uid;

  HomeScreen({Key key, @required this.name, @required this.uid}) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();


}

class _HomeScreenState extends State<HomeScreen> {

  BrewBloc _brewBloc;


  @override
  //called before the build only once
  void initState() {
    super.initState();
    _brewBloc = sl<BrewBloc>();      //brewBloc initialized:isLoading state initially

    //called after the build
    WidgetsBinding.instance
        .addPostFrameCallback((_) => {
      _brewBloc.dispatch(LoadData()),

    });        //dispatch event isLoaded

  }



  void _showSettingsPanel(String uid,BrewBloc brewblock){
    showModalBottomSheet(context: context,
        builder: (context){
          return Container(
            padding:EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child:SettingsForm(uid:uid,brewBloc: brewblock,),        ////////////////
          );
        });
  }



  @override
  Widget build(BuildContext context) {

    //print('Build');

    return BlocProvider(
      bloc: _brewBloc,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.grey[900],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                //It also uses BlocProvider in order to access the AuthenticationBloc via Build context
                // so that when a user pressed the logout button, we can dispatch the LoggedOut event.
                BlocProvider.of<AuthenticationBloc>(context).dispatch(
                  LoggedOut(),
                );
              },
            ),
            IconButton(
              icon:Icon(Icons.settings, color: Colors.white),

              onPressed: () => {
                _showSettingsPanel(widget.uid,_brewBloc),
              },//

            ),
          ],
        ),


        body:Container(
            decoration: BoxDecoration(
              image:DecorationImage(
                image:AssetImage('assets/coffee_bg.png'),
                fit:BoxFit.cover,
              ),
            ),
            child: BrewList()
        ),
//      Column(
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        children: <Widget>[
//          Text('Welcome $name!'),
//        ],
//      ),
      ),
    );
  }


}
