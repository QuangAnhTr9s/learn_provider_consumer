import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


//dùng Provider.of thì sẽ ko update Wiget nếu listen  = false
//dùng Consumer sẽ update Wiget
void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => MySetting(),
    child: const MaterialApp(
      home: MyApp(),
    ),
  ));
}

//LƯU Ý: thay đổi là phải notifyListeners();
class MySetting extends ChangeNotifier {
  String myText = 'qa';
  Color color = Colors.red;
  void changeText(){
    if(myText == 'Hello'){
      myText = 'World';
    } else{
      myText = 'Hello';
    }
    notifyListeners(); //thông báo có sự thay đổi
  }

  void changeColor(){
    if(color == Colors.red){
      color = Colors.green;
    } else{
      color = Colors.red;
    }
    notifyListeners();
  }

  set newColor(Color newColor){
    color = newColor;
    notifyListeners();
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MySetting>(
      builder: (context, mySetting, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('My App'),
          ),
          drawer: Drawer(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(onPressed: () {
                    mySetting.changeColor();
                    Navigator.pop(context);
                  }, child: const Text("Change Color")),
                  ElevatedButton(onPressed: () {
                    mySetting.changeText();
                    Navigator.pop(context);
                  }, child: const Text("Change Text")),
                  ElevatedButton(onPressed: () {
                    mySetting.newColor  = Colors.yellow;
                    Navigator.pop(context);
                  }, child: const Text("Change color by set"))
                ],
              ),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      mySetting.changeText();
                    }, child: const Text('Change Text'),),
                Text('${mySetting.myText}', style: TextStyle(fontSize: 35, color: mySetting.color),)
              ],
            ),
          ),
        );
      },
    );
  }
}
