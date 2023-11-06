import 'dart:io';

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  List<String> languages = [
    'Turkish',
    'English',
    'Russian',
    'Spanish',
    'German',
  ];
  List<String> languagescode = [
    'tr',
    'en',
    'ru',
    'es',
    'de',
  ];
  String from ="tr";
  String to ="en";
  String data = "Hello";
  String selectedValue = "Turkish";
  String selectedValue2 = "English";
  var tfcontroller=TextEditingController(text: "Merhaba");
  final formKey= GlobalKey<FormState>();
  bool yukleniyorMu=false;

  final translator = GoogleTranslator();

  translate() async {

    try{
      if(formKey.currentState!.validate()){
        await translator.translate(tfcontroller.text,from: from,to: to)
            .then((value){
          data=value.text;
          yukleniyorMu=false;

          setState(() {
          });
        });
      }
    }on SocketException catch(_){
      yukleniyorMu=true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("İnternete bağlı değilsiniz"),
          duration: Duration(seconds: 5),)
      );
    }

  }
  @override
  void dispose() {
    super.dispose();
    tfcontroller.dispose();
  }

  @override
  void initState() {
    super.initState();
    translate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Translate",style: TextStyle(color: Colors.white),),centerTitle: true,backgroundColor: Colors.grey[800],),
      backgroundColor: Colors.grey[700],
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 25,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 180,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:BorderRadius.circular(10)
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("From"),
                        DropdownButton(
                            value:selectedValue,
                            items: languages.map((item){
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                                onTap: (){
                                  if(item==languages[0]){
                                    from=languagescode[0];
                                  }else if(item==languages[1]){
                                    from = languagescode[1];
                                  }else if(item==languages[2]){
                                    from = languagescode[2];
                                  }else if(item==languages[3]){
                                    from = languagescode[3];
                                  }else if(item==languages[4]) {
                                    from = languagescode[4];
                                  }
                                  setState(() {

                                  });

                                },
                              );
                            }).toList(),
                            onChanged: (value){
                              selectedValue=value!;
                            })
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(width: 180,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:BorderRadius.circular(10)
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("To"),
                        DropdownButton(
                            value:selectedValue2,
                            items: languages.map((item){
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                                onTap: (){
                                  if(item==languages[0]){
                                    to=languagescode[0];
                                  }else if(item==languages[1]){
                                    to = languagescode[1];
                                  }else if(item==languages[2]){
                                    to = languagescode[2];
                                  }else if(item==languages[3]){
                                    to = languagescode[3];
                                  }else if(item==languages[4]) {
                                    to = languagescode[4];
                                  }
                                  setState(() {

                                  });

                                },
                              );
                            }).toList(),
                            onChanged: (value){
                              selectedValue2=value!;
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(25),
              margin: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
              ),
              child: Form(
                key: formKey,
                child: TextFormField(
                  controller:tfcontroller,
                  maxLines: null,
                  minLines: null,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Bir şeyler yazın";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),

                ),
              ),
            ),
        ElevatedButton(onPressed: translate,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black,minimumSize: Size(250, 50),shape: RoundedRectangleBorder()),
            child: Text("Translate",style: TextStyle(color: Colors.white),)),
        Container(
          padding: EdgeInsets.all(25),
          margin: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.grey[500],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
          ),
          child: Center(child: SelectableText(
            data,style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
          ),),)


            
          ],
        ),
      ),

    );
  }
}
