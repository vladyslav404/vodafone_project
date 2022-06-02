import 'package:flutter/material.dart';
import 'package:vodafone_project/utils/const.dart';

//todo decorate alert dialog
alertDialog(
    BuildContext context,
    {
      String title,
      String content,
      String optionOne,
      String optionTwo,
      Function optionOneFunc,
      Function optionTwoFunc,
      }
    ){
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: Text(str_retry),
          onPressed: () => optionOneFunc ?? Navigator.pop(context),
        ),
        TextButton(
          child: Text(str_resetPassword),
          onPressed: optionTwoFunc,
        ),
      ],
    ),
  );
}