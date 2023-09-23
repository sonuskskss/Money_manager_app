

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_manager_app/db_helper.dart';
import 'package:money_manager_app/pages/add_transaction.dart';

import 'income_expanse_tile_page.dart';
import 'income_expense_card_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

DBHelper dbHelper = DBHelper();

DateTime  today = DateTime.now();
int totalBalance = 0;
int totalIncome = 0;
int totalExpanse = 0;

List<FlSpot> dataSet = [];

List<FlSpot> getPlotPoints(Map entireData){
dataSet = [];
entireData.forEach((key, value) {

  if(value['type'] == "Expense" &&
      (value['date'] as DateTime).month == today.month){

    dataSet.add(FlSpot(
        (value['date'] as DateTime).day.toDouble(),
        (value['amount'] as int).toDouble()));
  }
});
  return dataSet;
}



getTotalBalance(Map entireData){
  totalBalance =0;
  totalIncome =0;
  totalExpanse =0;

  entireData.forEach((key, value) {

    if(value['type'] == 'Income'){
      totalBalance += (value['amount'] as int);
      totalIncome += (value['amount'] as int);
    }else{
      totalBalance -= (value['amount'] as int);
      totalExpanse += (value['amount'] as int);
    }

  });
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Color(0xffe2e7ef),
      // appBar: AppBar(
      //   toolbarHeight: 0.0,
      // ),

      body: FutureBuilder<Map>(

        future: dbHelper.fetch(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Container();
          }


          if(snapshot.hasData){

            if(snapshot.data!.isEmpty){
              return  ListView(

                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(

                          children: [
                            Container(
                              height: 50,
                              width: 70,
                              //padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white
                                ),


                                child: Image.asset('lib/assets/emogi-removebg-preview.png',fit: BoxFit.fill,),

                              //Image.asset('lib/assets/mitra.jpg',width: 60,)
                            ),


                            SizedBox(width: 8.0,),

                            Text('Welcome Dipak',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0,
                                  color: Colors.deepPurple),),


                          ],
                        ),



                        Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color:Color(0xffe2e7ef),
                            ),

                            child: Icon(Icons.settings,size: 32,color: Colors.black,)),
                      ],
                    ),
                  ),

                  Container(

                    width: MediaQuery.of(context).size.width *0.9,
                    margin: EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [

                                Colors.black,
                                Colors.blueAccent,


                              ]
                          ),

                          borderRadius: BorderRadius.all(
                              Radius.circular(24)
                          )
                      ),

                      padding: EdgeInsets.symmetric(vertical: 20,horizontal:8),
                      child: Column(
                        children: [

                          Text('Total Balance', textAlign: TextAlign.center,style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),),

                          SizedBox(height: 12,),

                          Text('Rs ${totalBalance}', textAlign: TextAlign.center,style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white
                          ),),

                          SizedBox(height: 12,),

                          Padding(padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                cardIncome(totalIncome.toString()),

                                cardExpense(totalExpanse.toString())
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                  //
                  //
                  //
                  Padding(padding: EdgeInsets.all(12),
                    child: Text('Expenses',style:
                    TextStyle(
                        fontSize: 25,
                        color: Colors.black87,
                        fontWeight: FontWeight.w900
                    ),),
                  ),


                  dataSet.length < 2 ?
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.4),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(0,4),
                          )
                        ]
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 40.0),
                    margin: EdgeInsets.all(12),
                    child: Text('Not enough Value top render chart',
                      style: TextStyle(
                        fontSize: 22,
                        color:Colors.black87,
                      ),
                    ),


                  )






                      : Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.4),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(0,4),
                          )
                        ]
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 40.0),
                    margin: EdgeInsets.all(12),
                    height: 300,
                    child: LineChart(
                        LineChartData(
                            borderData: FlBorderData(
                                show: false
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                  spots: getPlotPoints(snapshot.data!) ,
                                 // isCurved: false,
                                  barWidth: 2,
                                  color: Colors.deepPurpleAccent
                              )
                            ]
                        )
                    ),

                  ),




                  Padding(padding: EdgeInsets.all(12),
                    child: Text('Recent Expenses',style:
                    TextStyle(
                        fontSize: 25,
                        color: Colors.black87,
                        fontWeight: FontWeight.w900
                    ),),
                  ),

                  //
                  //
                  //

                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){

                        Map dataAtIndex = snapshot.data![index];
                        if(dataAtIndex['type'] == "Income"){
                          return incomeTile(dataAtIndex['amount'], dataAtIndex['note']);
                        }
                        else{
                          return expenseTile(dataAtIndex['amount'], dataAtIndex['note']);
                        }




                        return expenseTile(120, "note");

                      })


                ],
              );
            }

            getTotalBalance(snapshot.data!);
            getPlotPoints(snapshot.data!);
            return ListView(

              children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(

                    children: [
                      Container(
                        height: 50,
                        width: 70,
                        //padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xffe2e7ef),
                        ),


                        child: Image.asset('lib/assets/emogi-removebg-preview.png',fit: BoxFit.fill,),

                        //Image.asset('lib/assets/mitra.jpg',width: 60,)
                      ),


                      SizedBox(width: 8.0,),

                      Text('Welcome Dipak',
                      style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24.0,
                      color: Colors.deepPurple),),


                    ],
                  ),


                  
                  Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xffe2e7ef),
                      ),
                      
                      child: Icon(Icons.settings,size: 32,color: Colors.black54,)),
                ],
              ),
            ),

                Container(

                  width: MediaQuery.of(context).size.width *0.9,
                  margin: EdgeInsets.all(12),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.green,
                          Colors.blueAccent,
                          Colors.teal,
                        ]
                      ),

                      borderRadius: BorderRadius.all(
                        Radius.circular(24)
                      )
                    ),

                    padding: EdgeInsets.symmetric(vertical: 20,horizontal:8),
                    child: Column(
                      children: [

                        Text('Total Balance', textAlign: TextAlign.center,style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),),

                        SizedBox(height: 12,),

                        Text('Rs ${totalBalance}', textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),),

                        SizedBox(height: 12,),
                        
                        Padding(padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            cardIncome(totalIncome.toString()),
                            
                            cardExpense(totalExpanse.toString())
                          ],
                        ),
                        ),


                      ],
                    ),
                  ),
                ),
                //
                //
                //
                Padding(padding: EdgeInsets.all(12),
                child: Text('Expenses',style:
                  TextStyle(
                    fontSize: 25,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold
                  ),),
                ),


                 dataSet.length < 2 ?
          Container(
          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
          BoxShadow(
          color: Colors.grey.withOpacity(.4),
          spreadRadius: 5,
          blurRadius: 5,
          offset: Offset(0,4),
          )
          ]
          ),
          padding: EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 40.0),
          margin: EdgeInsets.all(12),
          child: Text('Not enough value top render chart',
          style: TextStyle(
            fontSize: 22,
            color:Colors.black87,
          ),
          ),


          )






                     : Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.4),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: Offset(0,4),
                      )
                    ]
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                  vertical: 40.0),
                  margin: EdgeInsets.all(12),
                  height: 300,
                  child:
                  LineChart(
                    LineChartData(
                      borderData: FlBorderData(
                        show: true
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: getPlotPoints(snapshot.data!) ,
                          isCurved: true,

                          barWidth: 2,
                          color: Colors.black87
                        )
                      ]
                    )
                  ),

                ),




                Padding(padding: EdgeInsets.all(12),
                child: Text('Recent Expenses',style:
                  TextStyle(
                    fontSize: 25,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold
                  ),),
                ),

                //
                //
                //

                ListView.builder(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){

                    Map dataAtIndex = snapshot.data![index];
                    if(dataAtIndex['type'] == "Income"){
                      return incomeTile(dataAtIndex['amount'], dataAtIndex['note']);
                    }
                    else{
                      return expenseTile(dataAtIndex['amount'], dataAtIndex['note']);
                    }
                    
                    
                    
                    
                    //return expenseTile(120, "note");

                })


              ],
            );
          }else{
            return Center(
              child: Text('Unexcepeted Error !'),
            );
          }


        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(

        onPressed: (){
          Navigator.push(context,
          MaterialPageRoute(
              builder: (context)=>AddTransaction()
          )
          ).whenComplete(() {
            setState(() {

            });
          });
        },
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0)
        ),
        child: Icon(Icons.add,size: 32, color: Colors.white,),
      ),
    );
  }


}
