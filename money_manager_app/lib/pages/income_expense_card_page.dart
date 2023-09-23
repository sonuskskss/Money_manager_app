


import 'package:flutter/material.dart';

Widget cardIncome(String value){

  return Row(
    children: [
      Container(

        decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(20.0)
        ),
        padding: EdgeInsets.all(6),
        child: Icon(Icons.arrow_downward,
            size: 30,color: Colors.green[700]
        ),
        margin: EdgeInsets.only(right: 8.0),
      ),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text('Income',style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),),

          Text(value,style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            fontWeight: FontWeight.bold
          ),)
        ],
      )

    ],
  );
}





Widget cardExpense(String value){

  return Row(
    children: [
      Container(

        decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(20.0)
        ),
        padding: EdgeInsets.all(6),
        child: Icon(Icons.arrow_upward,
            size: 30,color: Colors.red[700]
        ),
        margin: EdgeInsets.only(right: 8.0),
      ),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text('Expense',style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),),

          Text(value,style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            fontWeight: FontWeight.bold
          ),)
        ],
      )

    ],
  );
}

