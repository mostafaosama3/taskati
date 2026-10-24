import 'package:flutter/material.dart';

void pushTo(BuildContext context,Widget newscreen){
Navigator.push(context, MaterialPageRoute(builder:(context) => newscreen )
);
}
void pushReplacement(BuildContext context, Widget newScreen) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => newScreen));
}
void popTo(BuildContext context, Widget newScreen ){
 Navigator.pop(context,MaterialPageRoute(builder: (context) => newScreen));

}