

import 'package:flutter/material.dart';




Widget expenseTile(int value, String note){
  return Container(
    margin: EdgeInsets.all(8.0),

    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white60,
      borderRadius: BorderRadius.circular(8),

    ),

    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.arrow_circle_up_outlined,size: 29,
              color: Colors.red,),

            SizedBox(
              height: 4.0 ,
            ),

            Text("Expense",style: TextStyle(
              fontSize: 20,

            ),)
          ],
        ),

        Text("-$value",style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700
        ),)
      ],
    ),
  );
}







Widget incomeTile(int value, String note) {
  return Container(
    margin: EdgeInsets.all(8.0),

    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white60,
      borderRadius: BorderRadius.circular(8),

    ),

    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.arrow_circle_down_outlined,size: 29,
              color: Colors.green,),

            SizedBox(
              height: 4.0 ,
            ),

            Text("Income",style: TextStyle(
              fontSize: 20,

            ),)
          ],
        ),

        Text("+$value",style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700
        ),)
      ],
    ),
  );
}
