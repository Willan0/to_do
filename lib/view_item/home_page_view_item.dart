import 'package:flutter/material.dart';
import 'package:to_do/constant/color.dart';
import 'package:to_do/constant/dimen.dart';
import 'package:to_do/constant/string.dart';
import 'package:to_do/widget/easy_text.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key, required this.title, required this.trailingWidget}) : super(key: key);

  final String title;
  final Widget trailingWidget;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        EasyText(data: title,fontSize: kFi25x,),
        const Spacer(),
        trailingWidget
      ],
    );
  }
}


class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({Key? key, required this.date, required this.time}) : super(key: key);

  final String date;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        EasyText(data: date),
        const Spacer(),
        EasyText(data: time),
      ],
    );
  }
}
class FloatingActionView extends StatelessWidget {
  const FloatingActionView({Key? key, required this.onTap}) : super(key: key);

  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: ()=> onTap(),
      backgroundColor: cSecondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: const Icon(Icons.add,color: cBlack,),
    );
  }
}

class PopUpMenuView extends StatelessWidget {
  const PopUpMenuView({Key? key, required this.onSelected}) : super(key: key);

  final Function(String value) onSelected;
  @override
  Widget build(BuildContext context) {
    return  PopupMenuButton(
        onSelected: (value)=> onSelected(value),
        itemBuilder: (context) {
          return const [
            PopupMenuItem(value:kEditPopUp,child:  EasyText(data: kEditPopUp)),
            PopupMenuItem(value:kDeletePopUp,child:  EasyText(data: kDeletePopUp)),
          ];
        },
      child: const Icon(Icons.more_vert),
    );
  }
}




