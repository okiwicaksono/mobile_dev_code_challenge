import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Other Person'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _items = [];
  List<Grouping> grouping = <Grouping>[];
  String currentUser = "A";


  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/messagedataset.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["data"].reversed.toList();
      GroupingData(_items);
      grouping.forEach((element) {print(element.data);});
    });
  }

  void GroupingData(List _items){
    List temp = [];
    List temp2 = [];
    for(int i=0;i<_items.length;i++){

      if(_items[i]["attachment"]==null) {
        temp = [];
        temp.add(_items[i]);
        grouping.add(Grouping(type: "text", data: temp,looping: false));

      }else if(_items[i]["attachment"]=="image"){
        temp = [];
        temp.add(_items[i]);
        if((i+1)<_items.length && _items[i+1]["attachment"]=="image" && _items[i+1]["from"]==_items[i]["from"]){
          for(int o = i;o<_items.length;o++){
            if(_items[o+1]["attachment"]=="image" && _items[o+1]["from"]==_items[i]["from"]){
              temp.add(_items[o]);
            }else{
              i=o;
              o=_items.length;
            }
          }
          if(temp.length>=4){
            temp2.add(temp[0]);
            grouping.add(Grouping(type: "image", data: temp2,looping: true,sumOri: temp.length));
            temp2=[];
          }else{
            grouping.add(Grouping(type: "image", data: temp,looping: false));
          }

        }else{
          grouping.add(Grouping(type: "image", data: temp,looping: false));
        }

      }else if(_items[i]["attachment"]=="contact"){
        temp = [];
        temp.add(_items[i]);
        if((i+1)<_items.length && _items[i+1]["attachment"]=="contact" && _items[i+1]["from"]==_items[i]["from"]){
          for(int o = i;o<_items.length;o++){
            if(_items[o+1]["attachment"]=="contact" && _items[o+1]["from"]==_items[i]["from"]){
              temp.add(_items[o]);
            }else{
              i=o;
              o=_items.length;
            }
          }
          if(temp.length>=2){
            temp2.add(temp[0]);
            grouping.add(Grouping(type: "contact", data: temp2,looping: true,sumOri: temp.length));
            temp2=[];
          }else{
            grouping.add(Grouping(type: "contact", data: temp,looping: false));
          }
        }else{
          grouping.add(Grouping(type: "contact", data: temp,looping: false));
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(widget.title), leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child:
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                    child: grouping.isNotEmpty?Column(
                      children: List.generate(grouping.length, (index) => cardchat(index,grouping,context,currentUser)),
                    ):CircularProgressIndicator(),
                  ),
                )),
            Container(
              height: 60.0,
              width: double.infinity,
              // color: Colors.red,
              padding: EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10.0,top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.attach_file,size: 25.0,),
                  SizedBox(width: 10.0,),
                  Expanded(
                    child: Container(
                      height: 40.0,
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                         border: Border.all(width: 1,color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Text("Send A Message"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Icon(Icons.account_circle_outlined,size: 30.0,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget cardchat(int index,List<Grouping> _items,BuildContext context,String currentUser){
  return Column(
    children: List.generate(_items[index].data?.length ?? 0, (idx){
      return _items[index].data?[idx]["from"]==currentUser?
      Align(
          alignment: Alignment.topRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(15.0),
                width: MediaQuery.of(context).size.width-150.0,
                margin: EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child:
                    _items[index].type=="image" && _items[index].looping==true?
                    imageContent(4,_items[index].sumOri??0):
                    _items[index].type=="image" && _items[index].looping==false?
                    imageContent(1,0):
                    _items[index].type=="document"?document():
                    _items[index].type=="contact" && _items[index].looping==true?
                        contact(3):
                    _items[index].type=="contact"?
                      contact(1):
                    Text(_items[index].data![0]['body'].toString(),style: TextStyle(color: Colors.white),),
                ),
              SizedBox(width: 10.0,),
              Icon(Icons.account_circle_outlined,size: 40.0,),
            ],
          )
      ):
      Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: EdgeInsets.all(15.0),
            width: MediaQuery.of(context).size.width-150.0,
            margin: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.9),
                borderRadius: BorderRadius.circular(10.0)
            ),
            child:
            _items[index].type=="image" && _items[index].looping==true?
            imageContent(4,_items[index].sumOri??0):
            _items[index].type=="image" && _items[index].looping==false?
            imageContent(1,0):
            _items[index].type=="document"?document():
            _items[index].type=="contact" && _items[index].looping==true?
            contact(3):
            _items[index].type=="contact"?
            contact(1):
            Text(_items[index].data![0]['body'].toString(),style: TextStyle(color: Colors.white),),

          )
      );
    })
  );
}


Widget imageContent(int sumimage,int sum){
  if(sumimage==1){
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Image.network("https://pertaniansehat.com/v01/wp-content/uploads/2015/08/default-placeholder.png",fit:BoxFit.fill,),
      color: Colors.teal[100],
    );
  }
  return  Wrap(
    children: List.generate(sumimage, (index) =>
        index+1==sumimage?
        Stack(
          children:[
            Container(
            margin: EdgeInsets.all(10.0),
            child: Image.network("https://pertaniansehat.com/v01/wp-content/uploads/2015/08/default-placeholder.png",height: 80.0,width: 90.0,fit:BoxFit.fill,),
            color: Colors.green[100],
          ),
            sum==4?
            Container(
              margin: EdgeInsets.all(10.0),
                height: 80.0,width: 90.0,
              color: Colors.transparent
            ):Container(
              margin: EdgeInsets.all(10.0),
                height: 80.0,width: 90.0,
              color: Colors.black87.withOpacity(0.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("+ "+(sum-4).toString()+" More...",style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          ]
        ):
        Container(
        margin: EdgeInsets.all(10.0),
        child: Image.network("https://pertaniansehat.com/v01/wp-content/uploads/2015/08/default-placeholder.png",height: 80.0,width: 90.0,fit:BoxFit.fill,),
        color: Colors.teal[100],
      )
      ),
  );
}

Widget document(){
  return Row(
    children: [
      Icon(Icons.description,color: Colors.white,size: 40.0,),
      SizedBox(width: 10.0,),
      Text("This is document",style: TextStyle(color: Colors.white),)
    ],
  );
}

Widget contact(int sumOri){
  return sumOri>1?Row(
    children: [
      Icon(Icons.supervisor_account,color: Colors.white,size: 30.0,),
      SizedBox(width: 10.0,),
      Text("More than one person",style: TextStyle(color: Colors.white),)
    ],
  ):Row(
    children: [
      Icon(Icons.account_circle,color: Colors.white,size: 30.0,),
      SizedBox(width: 10.0,),
      Text("This is a person",style: TextStyle(color: Colors.white),)
    ],
  );
}

class Grouping{
  String? type;
  List? data;
  bool? looping;
  int? sumOri;

  Grouping({this.type,this.data,this.looping=false,this.sumOri});
}