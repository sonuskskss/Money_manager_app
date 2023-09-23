import 'package:flutter/material.dart';



import 'package:flutter/material.dart';
import 'package:money_manager_app/db_helper.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {

  int? amount;
  String note = "Some Expense";
  String type = "Income";
  DateTime selectedDate = DateTime.now();

  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];


Future<void> _selectedDate(BuildContext context)async {

  final DateTime? picked = await showDatePicker(context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020, 12),
      lastDate: DateTime(2030,12));

  if(picked!=null && picked != selectedDate){
    setState(() {
      selectedDate = picked;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(


        backgroundColor: Color(0xffe2e7ef),
      appBar: AppBar(

        backgroundColor: Color(0xffe2e7ef),
        toolbarHeight: 0.0,
      ),

      body: ListView(
        padding: EdgeInsets.all(12.0),

        children: [
         Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close, size: 25,color: Colors.deepPurple,)),
                  SizedBox(width: 15,)
                ],
              ),


         // SizedBox(height: 12,),
          Text("Add Transaction", textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold),),


          SizedBox(height: 20,),

          Row(
            children: [

              Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(16.0),

                  ),

                  padding: EdgeInsets.all(12.0),

                  child: Icon(Icons.attach_money,size: 24.0, color: Colors.white,)),


              SizedBox(width: 12,),

              Expanded(
                child: Container(
                  
                  decoration: BoxDecoration(
                   // color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Enter your money here...",
                        hintStyle: TextStyle(fontSize: 16),
                        contentPadding: EdgeInsets.only(bottom: 0)

                      ),

                      style: TextStyle(
                        fontSize: 24.0
                      ),

                      onChanged: (val){
                        try{
                          amount = int.parse(val);

                        }catch (e){

                        }


                      },

                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.0,),


          Row(
            children: [

              Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(16.0),

                  ),

                  padding: EdgeInsets.all(12.0),

                  child: Icon(Icons.description,size: 24.0, color: Colors.white,)),


              SizedBox(width: 12,),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextField(
                      maxLength: 100,
                    //  keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Note on transaction",
                        hintStyle: TextStyle(fontSize: 16),
                        contentPadding: EdgeInsets.only(bottom: 0),


                      //  border: InputBorder.none,

                      ),

                      style: TextStyle(
                          fontSize: 24.0
                      ),

                      onChanged: (val){
                        note =val;
                      },

                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.0,),



          Row(


            children: [

              Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(16.0),

                  ),

                  padding: EdgeInsets.all(12.0),

                  child: Icon(Icons.moving_sharp,size: 24.0, color: Colors.white,)),

              SizedBox(width: 12.0,),


              ChoiceChip(label: Text("Income",style: TextStyle(fontSize: 18,
                  color: type == "Income" ? Colors.white : Colors.deepPurple ),),

                  selectedColor: Colors.green,
                  selected: type == "Income" ? true : false,
              onSelected: (val){

                if(val){
                  setState(() {
                    type = "Income";
                  });
                }
              },
              ),

                 SizedBox(width: 12.0,),


              ChoiceChip(label: Text("Expense",style: TextStyle(fontSize: 18,
                  color: type == "Income" ? Colors.deepPurple :Colors.red  ),),

                selectedColor: Colors.yellow,
                selected: type == "Expense" ? true : false,
                onSelected: (val){

                  if(val){
                    setState(() {
                      type = "Expense";
                    });
                  }
                },
              ),

            ],
          ),

          SizedBox(height: 20,),

           SizedBox(
             height: 50,
             child: TextButton(onPressed: (){

               _selectedDate(context);
                     },
                 style: ButtonStyle(
                   padding: MaterialStateProperty.all(EdgeInsets.zero)
                 ),
                 child: Row(
                   children: [

                     Container(
                         decoration: BoxDecoration(
                           color: Colors.deepPurple,
                           borderRadius: BorderRadius.circular(16.0),

                         ),

                         padding: EdgeInsets.all(12.0),

                         child: Icon(Icons.calendar_month,size: 24.0, color: Colors.white,)),


                     SizedBox(width: 12,),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("${selectedDate.day} ${months[selectedDate.month - 1]}",style: TextStyle(fontSize: 20, ),),
                         Container(height: 1,
                         width: 300,
                         color: Colors.deepPurple,)
                       ],
                     ),
                   ],
                 )),
           ),

          SizedBox(height: 30,),

          InkWell(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12)
                      ,
                  color: Colors.deepPurple
                ),
                child: Center(
                  child: Text("Add", textAlign: TextAlign.center, style: TextStyle(
                    color: Colors.white,
                      fontSize: 25, fontWeight: FontWeight.bold),),
                ),
              ),
            onTap: ()async{
              if(amount!= null && note.isNotEmpty ){
                DBHelper dbHelper = DBHelper();
                await dbHelper.addData(amount!, selectedDate, note, type);
                Navigator.of(context).pop();

              }else{
              }

            },
          ),



        ],
      )

    );
  }
}



