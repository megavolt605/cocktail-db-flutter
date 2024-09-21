import 'package:flutter/material.dart';
import 'package:hello_flutter/api.dart';
import 'package:hello_flutter/models/filter_model.dart';
import 'drink_list_widget.dart';

class ListPage extends StatefulWidget {
  @override
  State<ListPage> createState() => _ListPage();
}

class _ListPage extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as FilterType;
    var future = Api.list.requestList(filterType: args);

    return Scaffold(
      appBar: AppBar(
        title: Text(args.name),
      ),
      body: Center(
        child: FutureBuilder<List<FilterModel>>(
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
    );
  }

  Widget createCell(FilterModel? item) {
    return SizedBox(height: 60.0, child: Center(child: Text(item?.name ?? '')));
  }

  Widget buildList(List<FilterModel> values) {
    final args = ModalRoute.of(context)!.settings.arguments as FilterType;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: values.length,
      itemBuilder: (context, index) {
        final value = values[index];
        return GestureDetector(
            onTap: () {
              Navigator.pushNamed(this.context, '/D',
                  arguments: DrinkListValue(
                      filterType: args, value: value.name ?? ''));
            },
            child: createCell(value));
      },
    );
  }
}
