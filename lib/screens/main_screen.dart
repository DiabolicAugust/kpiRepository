import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unidev/tools/constants.dart';
import 'package:unidev/tools/logic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myController = TextEditingController();
  List values = [];
  String link = 'http://repository.kpi.kharkov.ua/handle/KhPI-Press/47327';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(onGenerateRoute: (routeSettings) {
      GetInfo getItem = GetInfo();
      return MaterialPageRoute<void>(
        builder: (context) => Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.h),
                child: TextField(
                  controller: myController,
                ),
              ),
              CircleAvatar(
                radius: 70.r,
                backgroundColor: Colors.black,
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      values.insert(0, myController.text);
                    });
                  },
                  icon: Icon(Icons.add),
                ),
              ),
              Expanded(
                  child:ListView.builder(
                itemCount: values.length,
                itemBuilder: (context, index) {
                  if (values.isNotEmpty) {
                    return FutureBuilder<DocumentInfo>(
                        future: getItem.get(values[index]),
                        builder: (context, snapshot) {
                         if(snapshot.hasData){
                           return Dismissible(
                             key: UniqueKey(),
                             onDismissed: (direction) {
                               setState(() {
                                 // getItem.value.removeAt(index);
                               });
                             },
                             child: ListTile(
                               onLongPress: () {
                                 Clipboard.setData(
                                   ClipboardData(text: snapshot.data!.citation),
                                 );
                                 Fluttertoast.showToast(
                                     msg: "Text was copied to the clipboard",
                                     toastLength: Toast.LENGTH_SHORT,
                                     gravity: ToastGravity.CENTER,
                                     fontSize: 30.sp,
                                     timeInSecForIosWeb: 1);
                               },
                               title: Text(snapshot.data!.mainTitle),
                             ),
                           );
                         }else{
                           return ListTile(
                             tileColor: Constants.mainColor,
                             leading: SvgPicture.asset('lib/assets/khpi_logo.svg', color: Colors.white,),
                             title: Text('Loading...',style: TextStyle(fontSize: 18.sp),),
                           );
                         }
                        });
                  } else {
                    return Center(
                      child: Text('The list is empty'),
                    );
                  }
                },
              )),
            ],
          ),
        ),
      );
    });
  }
}
