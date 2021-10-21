import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nextflow_covid_today/covid_today_result.dart';
import 'package:nextflow_covid_today/stat_box.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nextflow COVID-19 Today',
      theme: ThemeData(primarySwatch: Colors.green),
      home: MyHomePage(title: 'COVID-19 Today'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    print('init state');
    getData();
  }

  Future<CovidTodayResult> getData() async {
    print('get Data');
    var url = Uri.parse(
        'https://covid19.th-stat.com/json/covid19v2/getTodayCases.json');
    var respons = await http.get(url);
    print(respons.body);

    var result = covidTodayResultFromJson(respons.body);
    return result;

    // setState(() {
    //   _dataFromWebAPI = covidTodayResultFromJson(respons.body);

    // });
  }

  @override
  Widget build(BuildContext context) {
    print('build');

    // var indicater;
    // if(_dataFromWebAPI == null){
    //   indicater =LinearProgressIndicator();
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: getData(),
        builder:
            (BuildContext context, AsyncSnapshot<CovidTodayResult> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var result = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              //======================================================111111111111====
              child: Column(
                children: <Widget>[
                  Container(
                    height: 150,//ขนาดกล่อง
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xB389F71B)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,//ลงล่าง
                      children: [
                        Text('ติดเชื้อสะสม',
                            style:
                                TextStyle(fontSize: 20, color: Colors.pink)),
                        Expanded(
                          child: Text(
                            '${NumberFormat("#,###").format(result?.confirmed) ?? "..."}',
                            //'${result?.confirmed ?? "..."}',
                            style: 
                            TextStyle(fontSize: 50, color: Colors.white),
                            textAlign: TextAlign.right,
                          ),
                        )
                      ],
                    ),
                  ),
                  //=============================================
                  SizedBox(height: 10,),//ตั่วคั่น
                  StatBox(
                    title: 'หายแล้ว', 
                    total: result?.recovered,
                    bgcolor: Color(0xff00b4b4),
                    ),
                  // ListTile(
                  //   title: Text('หายแล้ว'),
                  //   subtitle: Text('${result?.recovered ?? "..."}'),
                  // ), 2222
                  SizedBox(height: 10,),//ตั่วคั่น
                   StatBox(
                    title: 'อยู่ในโรงบาล', 
                    total: result?.hospitalized,
                    bgcolor: Color(0xffF7ED1B),
                    ),
                  // ListTile(
                  //   title: Text('อยู่ในโรงบาล'),
                  //   subtitle: Text('${result?.hospitalized ?? "..."}'),
                  // ), 3333
                  SizedBox(height: 10,),//ตั่วคั่น
                  StatBox(
                    title: 'เสียชีวิต', 
                    total: result?.deaths,
                    bgcolor: Colors.red,
                    ),
                  // ListTile(
                  //   title: Text('เสียชีวิต'),
                  //   subtitle: Text('${result?.deaths ?? "..."}'),
                  // )
                ],
              ),
            );
          }
          return LinearProgressIndicator();
        },
      ),

      // body: Column(
      //   children: <Widget>[
      //     indicater ?? Container(),
      //     Expanded(

      //     )
      //   ],
      // )
    );
  }
}
