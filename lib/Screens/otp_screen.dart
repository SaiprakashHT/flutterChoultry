import 'package:flutter/material.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// ignore: unused_import, unnecessary_import
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';


class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      )
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('OTP TextFeild'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child:Container(
          margin: const EdgeInsets.only(top: 40),
          width: double.infinity,
        
          child: Column(
            children: [
              const Text("Verification", 
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 40),
                child: const Text("Enter the code sent to your number",
                style: TextStyle(color: Colors.grey,
                fontSize: 18,
                ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: const Text("+91 8431148811", 
                  style: TextStyle(
                  color: Colors.black, 
                  fontSize: 18),),
              ),
              Pinput(
                length: 6,
                defaultPinTheme:defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.green),
                  )
                ),
                onCompleted: (pin) => debugPrint(pin),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  //   return Form(
      
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         SizedBox(
  //           height: 68,
  //           width: 64,
  //           child: TextFormField(
  //             onChanged: (value) {
  //               if(value.length == 1){
  //                    FocusScope.of(context).nextFocus();
  //               }
  //             },
  //             onSaved: (pin1) {},
  //             decoration: const InputDecoration(hintText: "0"),
  //             style: Theme.of(context).textTheme.headline6,
  //             keyboardType: TextInputType.number,
  //             textAlign: TextAlign.center,
  //             inputFormatters: [
  //               LengthLimitingTextInputFormatter(1),
  //               FilteringTextInputFormatter.digitsOnly,
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           height: 68,
  //           width: 64,
  //           child: TextFormField(
  //             onChanged: (value) {
  //               if(value.length == 1){
  //                    FocusScope.of(context).nextFocus();
  //               }
  //             },
  //             onSaved: (pin2) {},
  //             decoration: const InputDecoration(hintText: "0"),
  //             style: Theme.of(context).textTheme.headline6,
  //             keyboardType: TextInputType.number,
  //             textAlign: TextAlign.center,
  //             inputFormatters: [
  //               LengthLimitingTextInputFormatter(1),
  //               FilteringTextInputFormatter.digitsOnly,
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           height: 68,
  //           width: 64,
  //           child: TextFormField(
  //             onChanged: (value) {
  //               if(value.length == 1){
  //                    FocusScope.of(context).nextFocus();
  //               }
  //             },
  //             onSaved: (pin3) {},
  //             decoration: const InputDecoration(hintText: "0"),
  //             style: Theme.of(context).textTheme.headline6,
  //             keyboardType: TextInputType.number,
  //             textAlign: TextAlign.center,
  //             inputFormatters: [
  //               LengthLimitingTextInputFormatter(1),
  //               FilteringTextInputFormatter.digitsOnly,
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           height: 68,
  //           width: 64,
  //           child: TextFormField(
  //             onChanged: (value) {
  //               if(value.length == 1){
  //                    FocusScope.of(context).nextFocus();
  //               }
  //             },
  //             onSaved: (pin4) {},
  //             decoration: const InputDecoration(hintText: "0"),
  //             style: Theme.of(context).textTheme.headline6,
  //             keyboardType: TextInputType.number,
  //             textAlign: TextAlign.center,
  //             inputFormatters: [
  //               LengthLimitingTextInputFormatter(1),
  //               FilteringTextInputFormatter.digitsOnly,
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
      
  //   );
   

