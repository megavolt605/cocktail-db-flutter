import 'package:flutter/material.dart';
import 'package:hello_flutter/api.dart';
import 'package:hello_flutter/models/drink_info_model.dart';
import 'package:hello_flutter/models/ingredient_model.dart';

class IngredientValue {
  String id;
  String name;
  IngredientValue({required this.id, required this.name});
}

class IngredientPage extends StatefulWidget {
  @override
  IngredientState createState() => IngredientState();
}

class IngredientState extends State<IngredientPage> {
  bool loaded = false;
  DrinkInfoModel? data;

  @override
  void initState() {
    super.initState();

    asyncInit();
  }

  Future<void> asyncInit() async {}

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as IngredientValue;
    var future = Api.lookup.requestIngridientInfo(ingridientId: args.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(args.name),
      ),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            final values = snapshot.data!;
            return buildInfo(values);
          } else {
            return Text("No data available ${snapshot.error}");
          }
        }, // Text(loaded ? 'Loaded' : 'Loading'),
      ),
    );
  }

  Widget buildInfo(IngredientModel item) {
    var url =
        'https://www.thecocktaildb.com/images/ingredients/${item.name}.png';
    print(url);
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(url)),
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text('Description',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                )),
            Text(item.description ?? ''),
            SizedBox(height: 16.0),
            Text('Type',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                )),
            Text(item.type ?? ''),
            SizedBox(height: 16.0),
            Text('Alcoholic',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                )),
            Text(item.alcohol ?? ''),
          ])
        ]));
  }
}
