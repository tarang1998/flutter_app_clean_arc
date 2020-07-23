

import 'package:brew_app_clean_arc/core/widgets/Loading.dart';
import 'package:brew_app_clean_arc/features/brew/presentation/bloc/bloc.dart';
import 'package:brew_app_clean_arc/features/brew/presentation/widgets/BrewTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class BrewList extends StatefulWidget {

  BrewList({Key key});



  @override
  _BrewListState createState() => _BrewListState();
}



class _BrewListState extends State<BrewList> {


  BrewBloc _brewBloc;


  @override
  void initState() {
    super.initState();
    _brewBloc = BlocProvider.of<BrewBloc>(context);

  }


  @override
  Widget build(BuildContext context) {




    //access data from the stream
    //final brews=Provider.of<List<Brew>>(context)??[];



    return BlocBuilder(
        bloc: _brewBloc,
        builder: (BuildContext context, BrewState state){
          if(state is BrewLoading){
            return Loading();
          }

          if(state is BrewLoaded){
            return ListView.builder(
                itemCount: state.brew.length,
                itemBuilder: (context,index) {
                  return BrewTile(
                      brew:state.brew[index]
                  );
                }
            );
          }
          else{
            return Container();
          }




    },
      //child:Container(),
    );

  }
}
