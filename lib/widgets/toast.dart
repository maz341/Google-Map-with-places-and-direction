

import 'package:toast/toast.dart';


showToast(String msg, context){
  return Toast.show(msg, context,
      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
}