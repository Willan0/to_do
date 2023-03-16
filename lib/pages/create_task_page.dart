import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/bloc/create_task_bloc.dart';
import 'package:to_do/constant/color.dart';
import 'package:to_do/constant/dimen.dart';
import 'package:to_do/utils/extension.dart';
import 'package:to_do/utils/screen_extension.dart';

import '../data/vos/task_vo.dart';
import '../view_item/create_task_view_item.dart';
import '../widget/easy_text.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({Key? key,this.postId = -1}) : super(key: key);

  final int postId;
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    return Form(
      key: globalKey,
      child: ChangeNotifierProvider(
        create: (context) => CreateTaskBloc(postId),
        child: Scaffold(
          appBar: AppBar(
            title:  const EasyText(
              data: ' Task',
              fontWeight: FontWeight.w600,
            ),
            backgroundColor: cSecondaryColor,
            centerTitle: true,
            leading: IconButton(
              onPressed: () => previousScreenPush(context),
              icon: const Icon(Icons.navigate_before,color: cBlack,),
            ),
          ),
          backgroundColor: cSecondaryColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kMp20x),
              child: Selector<CreateTaskBloc,TaskVO?>(
                selector: (_,selector)=> selector.getTaskVO,
                  builder: (_,taskVO,__)=>

                   CreateTaskItemView(taskVO:taskVO ,globalKey: globalKey,)

              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CreateTaskItemView extends StatelessWidget {
  const CreateTaskItemView({
    Key? key, required this.taskVO, required this.globalKey,
  }) : super(key: key);
  final TaskVO? taskVO;
  final GlobalKey<FormState> globalKey;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: kMp20x,
      ),
      NoteItemView(
        title: "Title",
        maxLine: 1,
        controller: context.getCreateTaskBlocInstance().getTitleController,
        taskVO: taskVO,
      ),
      NoteItemView(
        title: "Description",
        maxLine: 6,
        controller: context.getCreateTaskBlocInstance().getDescriptionController,
        taskVO: taskVO,
      ),
      NoteItemView(
        title: "Note",
        maxLine: 2,
        controller: context.getCreateTaskBlocInstance().getNoteController,
        taskVO: taskVO,
      ),
      const SizedBox(
        height: kMp20x,
      ),
      Selector<CreateTaskBloc,DateTime>(
          selector: (_,selector)=> selector.getDateTime,
          builder: (_,dateTime,__)=> DateAndTimeItemView(dateTime: dateTime,)),
      SaveButtonView(globalKey: globalKey,),
    ]);
  }
}


