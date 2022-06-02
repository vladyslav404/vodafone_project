import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vodafone_project/Servisler.dart';
import 'package:vodafone_project/providers/home.dart';
import 'package:vodafone_project/utils/const.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(str_dashboard),
      ),
      body: GridView.builder(
        itemCount: 5,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(32), color: srvLst[index].color),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            srvLst[index].title ?? "",
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          flex: 3,
                        ),
                        Expanded(
                          flex: 1,
                          child: Image(
                            image: AssetImage(srvLst[index].image),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        srvLst[index].description ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        srvLst[index].data ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        srvLst[index].description2 ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        srvLst[index].data2 ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black.withOpacity(0.1),
                      ),
                      onPressed: () => Navigator.pushNamed(
                        context,
                        Provider.of<HomeProvider>(context,listen: false).chooseStatistics(srvLst[index].title),
                      ),
                      child: Text(
                        str_seeMore,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
