
import 'package:flutter/material.dart';

import 'easy_text.dart';

class LoadingDialogWidgetView extends StatelessWidget {
  const LoadingDialogWidgetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: const [
          CircularProgressIndicator(),
          SizedBox(width: 20,),
          EasyText(data: 'Loading',fontWeight: FontWeight.bold,fontSize: 20,)
        ],
      ),
    );
  }
}