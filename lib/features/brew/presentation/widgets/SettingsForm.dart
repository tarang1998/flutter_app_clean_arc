

import 'package:brew_app_clean_arc/core/widgets/Loading.dart';
import 'package:brew_app_clean_arc/core/widgets/constants.dart';
import 'package:brew_app_clean_arc/features/brew/domain/entities/userdata.dart';
import 'package:brew_app_clean_arc/features/brew/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class SettingsForm extends StatefulWidget {

  final String uid;
  final BrewBloc brewBloc;

  SettingsForm({@required this.uid,@required this.brewBloc});


  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {


  final _formKey=GlobalKey<FormState>();
  final List<String> sugars=['0','1','2','3','4'];
  final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];
   BrewBloc brew_Bloc;
  //AuthenticationBloc Authbloc;


  String _currentName;
  String _currentSugars;
  int _currentStrength;


  @override
  void initState(){
    brew_Bloc=widget.brewBloc;
    //brew_Bloc=BlocProvider.of<BrewBloc>(context);
    //Authbloc=BlocProvider.of<AuthenticationBloc>(context);
    brew_Bloc.dispatch(SettingsClicked(uid:widget.uid));
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder(
        bloc:brew_Bloc,
        builder: (context, BrewState state ) {
          if(state is UserDataLoaded ){

            UserData userData=state.userdata;

            return Form(
              key:_formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew setting',
                    style:TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: TextInputDecoration.copyWith(
                        hintText: 'Enter Name'
                    ),
                    validator: (val)=>val.isEmpty?'Please enter a name':null,
                    onChanged: (val)=>setState(()=>_currentName=val),
                  ),
                  SizedBox(height:20),
                  //dropdown
                  DropdownButtonFormField(
                    decoration:TextInputDecoration,
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar){
                      return DropdownMenuItem(
                        value:sugar,
                        child:Text('$sugar sugars'),

                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _currentSugars = value ),

                  ),
                  SizedBox(height: 10.0),

                  //slider
                  Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    activeColor: Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) => setState(() => _currentStrength = val.round()),
                  ),
                  RaisedButton(
                      color:Colors.grey[400],
                      child:Text(
                        'Update',
                        style:TextStyle(color:Colors.white),

                      ),
                      onPressed: () async {
                        print(_currentName);
                        print(_currentStrength);
                        print(_currentSugars);

                        if (_formKey.currentState.validate()) {
                          brew_Bloc.dispatch(UpdateUserDataEvent(userdata:UserData(uid:widget.uid,sugars:_currentSugars ?? userData.sugars,name: _currentName ?? userData.name, strength:_currentStrength ?? userData.strength)));
                          Navigator.pop(context);
                        }
                      }
          ),


                ],
              ),

            );
          } else{
            return Loading();
          }

        }
    );
  }
}


