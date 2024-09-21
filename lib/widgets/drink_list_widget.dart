import 'package:flutter/material.dart';
import 'package:hello_flutter/api.dart';
import 'package:hello_flutter/models/drink_model.dart';
import 'drink_info_widget.dart';

class DrinkListValue {
  FilterType filterType;
  String value;
  DrinkListValue({required this.filterType, required this.value});
}

class DrinkListPage extends StatefulWidget {
  @override
  State<DrinkListPage> createState() => _DrinkListPage();
}

class _DrinkListPage extends State<DrinkListPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DrinkListValue;
    var future = Api.filter
        .requestDrinkList(filterType: args.filterType, value: args.value);
    print(future);
    return Scaffold(
      appBar: AppBar(
        title: Text(args.value),
      ),
      body: SafeArea(
        left: true,
        top: true,
        right: true,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: FutureBuilder<List<DrinkModel>>(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  final values = snapshot.data!;
                  return buildList(values);
                } else {
                  return Text("No data available ${snapshot.error}");
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget createCell(DrinkModel? item) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(item?.image ?? ''),
        ),
        SizedBox(height: 8.0),
        Text(
          item?.name ?? '',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget buildList(List<DrinkModel> values) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 20.0, crossAxisCount: 2, mainAxisExtent: 250.0),
        physics: const BouncingScrollPhysics(),
        itemCount: values.length,
        itemBuilder: (context, index) {
          final value = values[index];
          return GestureDetector(
              onTap: () {
                Navigator.pushNamed(this.context, '/DI',
                    arguments: DrinkInfoValue(
                        drinkId: value.id ?? '', name: value.name ?? ''));
              },
              child: createCell(value));
        });
  }
}
