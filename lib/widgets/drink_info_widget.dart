import 'package:flutter/material.dart';
import 'package:hello_flutter/api.dart';
import 'package:hello_flutter/models/drink_info_model.dart';
import 'ingredient_widget.dart';

class DrinkInfoValue {
  String drinkId;
  String name;
  DrinkInfoValue({required this.drinkId, required this.name});
}

class DrinkInfoPage extends StatefulWidget {
  @override
  DrinkInfoPageState createState() => DrinkInfoPageState();
}

class DrinkInfoPageState extends State<DrinkInfoPage> {
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
    final args = ModalRoute.of(context)!.settings.arguments as DrinkInfoValue;
    var future = Api.lookup.requestDrinkInfo(drinkId: args.drinkId);
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
        },
      ),
    );
  }

  Widget buildInfo(DrinkInfoModel item) {
    List<Widget> ingredients = item.ingredients.map((value) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/I',
              arguments: IngredientValue(
                  id: value.name ?? '', name: value.name ?? ''));
        },
        child: Row(children: [
          Text(value.name ?? '',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              )),
          Spacer(),
          Text(value.measure ?? ''),
          Icon(Icons.arrow_right),
        ]),
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(item.imageURL ?? ''),
        ),
        SizedBox(height: 10.0),
        Card.filled(
          color: Colors.cyanAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Ingredients',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: ingredients,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'Category',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(item.category ?? ''),
        SizedBox(height: 10.0),
        Text(
          'Type',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(item.type ?? ''),
        SizedBox(height: 10.0),
        Text(
          'Glass',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(item.glass ?? ''),
        SizedBox(height: 10.0),
        Text(
          'Instructions',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(item.instructions ?? ''),
        SizedBox(height: 10.0),
        Text(
          'Date',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(item.modifiedDate ?? ''),
      ]),
    );
  }
}
