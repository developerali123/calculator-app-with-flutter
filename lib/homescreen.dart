import 'package:flutter/material.dart';
import 'package:calculator_app/constant.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Calculator App'),
      ),
      backgroundColor: Colors.black,
      body: Calculator(),
    );
  }
}


class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var input="";
  var output="0";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(input.toString(),style: TextStyle(color: Colors.white,fontSize: 30),),
                ),
                SizedBox(height: 15,),
                Align(alignment:Alignment.bottomRight,child: Text(output.toString(),style: TextStyle(color: Colors.white,fontSize: 30),),),
              ],
            ),
          )),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Row(
                  children: [
                    MyButton(title:'AC',onpress: (){input='';output='0';setState((){});},),
                    MyButton(title:'+/-',onpress: (){print('tap');},),
                    MyButton(title:'%',onpress: (){input+='%';setState((){});},),
                    MyButton(title:'/',color: orangecolor,onpress: (){input+='/';setState((){});},)
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    MyButton(title:'7',onpress: (){input+='7';setState((){});},),
                    MyButton(title:'8',onpress: (){input+='8';setState((){});},),
                    MyButton(title:'9',onpress: (){input+='9';setState((){});},),
                    MyButton(title:'*',color: orangecolor,onpress: (){input+='*';setState((){});},)
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    MyButton(title:'4',onpress: (){input+='4';setState((){});},),
                    MyButton(title:'5',onpress: (){input+='5';setState((){});},),
                    MyButton(title:'6',onpress: (){input+='6';setState((){});},),
                    MyButton(title:'-',color: orangecolor,onpress: (){input+='-';setState((){});},)
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    MyButton(title:'1',onpress: (){input+='1';setState((){});},),
                    MyButton(title:'2',onpress: (){input+='2';setState((){});},),
                    MyButton(title:'3',onpress: (){input+='3';setState((){});},),
                    MyButton(title:'+',color: orangecolor,onpress: (){input+='+';setState((){});},)
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    MyButton(title:'0',onpress: (){input+='0';setState((){});},),
                    MyButton(title:'.',onpress: (){input+='.';setState((){});},),
                    MyButton(title:'DEL',onpress: (){input=input.substring(0,input.length-1);setState((){});},),
                    MyButton(title:'=',color: orangecolor,onpress: (){equalpress();setState((){});},)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void equalpress(){
    Parser p=Parser();
    Expression expression=p.parse(input);
    ContextModel contextModel=ContextModel();
    double eval=expression.evaluate(EvaluationType.REAL, contextModel);
    output=eval.toString();
  }
}


class MyButton extends StatelessWidget {
  final title;
  final color;
  final VoidCallback onpress;
  const MyButton({Key? key,required this.title,this.color=greycolor,required this.onpress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onpress,
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Center(child: Text(title,style: heading,)),
        ),
      ),
    );
  }
}
