import 'package:dog_breed_app/bloc/dog_bloc.dart';
import 'package:dog_breed_app/event/dog_event.dart';
import 'package:dog_breed_app/state/dog_state.dart';
import 'package:dog_breed_app/ui/shared/uicolor.dart';
import 'package:dog_breed_app/ui/shared/uipath.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ViewSplash extends StatelessWidget {
  const ViewSplash({super.key});

  @override
  Widget build(BuildContext context) {
    final dogBloc = BlocProvider.of<DogBloc>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      dogBloc.add(GetBreedsEvent());
    });

    return Scaffold(body: BlocBuilder<DogBloc, DogState>(
      builder: (context, state) {
        if (state.breeds.isNotEmpty) {
          print("state:" + state.toString());
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.popAndPushNamed(context, '/home');
          });
        }
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: UIColor.white),
          child: Center(
            child: SvgPicture.asset(
              UIPath.logo,
              width: 64,
            ),
          ),
        );
      },
    ));
  }
}
