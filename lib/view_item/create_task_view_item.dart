import 'package:flutter/material.dart';
import 'package:to_do/data/vos/task_vo.dart';
import 'package:to_do/utils/extension.dart';
import 'package:to_do/utils/screen_extension.dart';
import 'package:to_do/widget/dialog_view.dart';

import '../constant/color.dart';
import '../constant/dimen.dart';
import '../widget/easy_text.dart';

class NoteItemView extends StatelessWidget {
  const NoteItemView({
    Key? key, required this.title, required this.maxLine, required this.controller, required this.taskVO,
  }) : super(key: key);
  final String title;
  final int maxLine;
  final TaskVO? taskVO;
  final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kMp20x,),
          EasyText(data: title,fontSize: kFi20x,),
          const SizedBox(height: kWh10x,),
          Container(
            decoration: BoxDecoration(
                color: cWhite,
                borderRadius: BorderRadius.circular(kMp10x)
            ),
            child: TextFormField(
              validator: (value){
                if(value?.isEmpty ?? false){
                  return 'You must write';
                }
                return null;
              },
              controller: controller,
              maxLines: maxLine,
              onChanged: (text){
                context.getCreateTaskBlocInstance().setEdit();
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRi10x)
                  )
              ),
            ),
          )
        ]);
  }
}

class DateAndTimeItemView extends StatefulWidget {
  const DateAndTimeItemView({Key? key, required this.dateTime}) : super(key: key);

  final DateTime dateTime;

  @override
  State<DateAndTimeItemView> createState() => _DateAndTimeItemViewState();
}

class _DateAndTimeItemViewState extends State<DateAndTimeItemView> {
  @override
  Widget build(BuildContext context) {
    TimeOfDay timeOfDay = TimeOfDay.now();

    void setTime (){
      showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
          setState(() {
            if(value!= null){
              timeOfDay = value;
            }
            print('============================> ${timeOfDay.format(context)}');
          });
      });
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
        onPressed: (){
          showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1990),
              lastDate: DateTime(2100)
          ).then((value) {
                context.getCreateTaskBlocInstance().setDateTime(value);
                context.getCreateTaskBlocInstance().setEdit();
          });
        }, child:  Text(context.getCreateTaskBlocInstance().getDate)),
         const Spacer(),
        TextButton(onPressed:()=> setTime(), child:  Text(timeOfDay.format(context).toString())),
      ],
    );
  }
}
class SaveButtonView extends StatelessWidget {
  const SaveButtonView({
    Key? key, required this.globalKey,
  }) : super(key: key);

  final GlobalKey<FormState> globalKey;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: cSecondaryColor,
      onPressed:
        () {
        if(globalKey.currentState?.validate() ?? false){
          showDialog(context: context, builder: (context)=>
          const LoadingDialogWidgetView());
          context.getCreateTaskBlocInstance().onTapAdd().then((value) {
            previousScreenPush(context);
            previousScreenPush(context);
          }).catchError((error){
            previousScreenPush(context);
          });
        }
    }
    ,
      child: const Text('Save'),
    );
  }
}
