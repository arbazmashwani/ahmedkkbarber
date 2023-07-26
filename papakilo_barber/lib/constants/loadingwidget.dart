import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:papakilo_barber/constants/colors.dart';

class LoadingWidget extends StatelessWidget {
  final double size;

  LoadingWidget({this.size = 80});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitDoubleBounce(
        color: themecolorDarkBlue,
        size: size,
      ),
    );
  }
}

showloadingwidget(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: LoadingWidget(),
        );
      });
}
