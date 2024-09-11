import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratailapp/Widget/AppEevatedButton.dart';
import 'package:ratailapp/Widget/AppTextField.dart';

class AddBalanceScreen extends StatefulWidget {
  const AddBalanceScreen({Key? key}) : super(key: key);

  @override
  State<AddBalanceScreen> createState() => _AddBalanceScreenState();
}

class _AddBalanceScreenState extends State<AddBalanceScreen> {
  final TextEditingController AmountETController = TextEditingController();

  int _val=0;
  bool ch1=false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Padding(
        padding: const EdgeInsets.all(30.0),
    child:Card(
  elevation: 5,
      child: Container
    (
        height: 270,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Padding(
          padding:  EdgeInsets.fromLTRB(20, 5, 20, 0),
          child: Column(
            crossAxisAlignment:  CrossAxisAlignment.start,
            children: [
                 Text("Amount"),
              AppTextFieldWidget(
                controller: AmountETController,
                hintText: 'Amount',
                obscureText: true,
                validator: (value) {
                  if ((value?.isEmpty ?? true) &&
                      ((value?.length ?? 0) < 6)) {
                    return 'Enter password more than 6';
                  }
                  return null;
                },
                onChanged: (value){
                  //email=value!;

                },
              ),
              SizedBox(height: 5,),
              Text("Payment Method"),

              Row(
                children: [
                  Radio(value: 1, groupValue:_val , onChanged: (value) {
                    setState(() {
                      _val = value!;
                      print("Button value: $value");
                    });


                  }
                  ),
                  Text('Credit & waiiet'),

                ],
              ),
              SizedBox(height: 5,),
              Text("No Payment Method"),
              Padding(
                padding:  EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: AppTextFieldWidget(
                  controller: AmountETController,
                  hintText: 'Amount',
                  obscureText: true,
                  validator: (value) {
                    if ((value?.isEmpty ?? true) &&
                        ((value?.length ?? 0) < 6)) {
                      return 'Enter password more than 6';
                    }
                    return null;
                  },
                  onChanged: (value){
                    //email=value!;

                  },
                ),
              ),
              SizedBox(height: 5,),

              Row(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 25,
                    width: 80,
                    child: AppElevatedButton(
                      Color: Colors.green,
                      onTap: () {
                     //   Navigator.of(context).pop();
                        //Navigator.push(context, MaterialPageRoute(builder: (context) =>  LogInScreen()));
                      },
                      child: Center(
                        child: Text(
                          "Confirm",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              //fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),











            ],
          ),
        )),
      ),
),
    );
  }
}
