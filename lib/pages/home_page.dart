import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/bloc/home_page_bloc.dart';
import 'package:to_do/constant/color.dart';
import 'package:to_do/constant/dimen.dart';
import 'package:to_do/constant/string.dart';
import 'package:to_do/data/vos/task_vo.dart';
import 'package:to_do/pages/create_task_page.dart';
import 'package:to_do/utils/extension.dart';
import 'package:to_do/utils/screen_extension.dart';
import 'package:to_do/widget/easy_text.dart';

import '../view_item/home_page_view_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> HomePageBloc(),
      child: Scaffold(
        floatingActionButton: FloatingActionView(
          onTap: (){
            nextScreenPush(context,const CreateTaskPage());
          },
        ),
        backgroundColor: cPrimaryColor,
        appBar: AppBar(
          backgroundColor: cSecondaryColor,
          leadingWidth: kWh100x,
          actions: const [ Icon(Icons.notes,color: cBlack,),SizedBox(width: kWh10x,)],
          leading: const Center(child: EasyText(data: 'My Note',fontSize: kFi20x,)),
        ),
        body: Selector<HomePageBloc,List<TaskVO>?>(
          selector: (_,selector)=> selector.getTaskVOList,
          builder: (_,taskVOList,__){
            if(taskVOList == null){
              return const Center(child:  CircularProgressIndicator());
            }
            if(taskVOList.isEmpty){
              return const Center(child:  EasyText(data: 'Empty'));
            }
            return ListView.builder(
              itemCount: taskVOList.length,
              itemBuilder: (context, index) =>
                  Padding(
                    padding: const EdgeInsets.only(left: kMp5x),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(kMp10x),
                        child:  HomePageItemView(taskVO: taskVOList[index] ,),
                      ),
                    ),
                  ),
            );
          },
        )
        ),
    );
  }
}

class HomePageItemView extends StatelessWidget {
  const HomePageItemView({
    Key? key, required this.taskVO,
  }) : super(key: key);
  final TaskVO taskVO;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        TitleWidget(title: taskVO.title ?? '',
          trailingWidget: PopUpMenuView(
            onSelected: (value){
              if(value== kEditPopUp){
                nextScreenPush(context, CreateTaskPage(postId: taskVO.id ?? -1,));
              }
              if(value== kDeletePopUp){
                context.getHomePageBlocInstance()
                    .deleteTask(taskVO.id?? 1)
                    .then((value) {})
                    .catchError((e){});
              }
            },
          ),),
        const SizedBox(height: kMp20x,),
        Text(taskVO.description ?? '',maxLines: 2,overflow: TextOverflow.ellipsis,style: const TextStyle(
          fontSize: kFi14x,
          color: cBlackShadow,
        ),),
        const SizedBox(height: kMp10x,),
        EasyText(data: 'note : ${taskVO.note ?? ""}'),
        const SizedBox(height: kMp10x,),
        DateTimeWidget(date: taskVO.date ??'',time: taskVO.time?? '',),
      ],
    );
  }
}
