import 'package:flutter/material.dart';
import 'package:hello_flutter/api.dart';

final class HomePage extends StatelessWidget {
  Widget makeButton({required FilterType kind}) {
    return SizedBox(
      width: 160.0,
      height: 44.0,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(_context, '/L', arguments: kind);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          elevation: 4,
        ),
        child: Text(kind.name),
      ),
    );
  }

  late final BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Cocktail !!!DB',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10.0),
            ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: const Image(
                  image: AssetImage('assets/cocktails.jpg'),
                  height: 150.0,
                  fit: BoxFit.fill,
                )),
            SizedBox(height: 20.0),
            const Text(
              'Please select filter',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w200,
              ),
            ),
            SizedBox(height: 20.0),
            Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                makeButton(kind: FilterType.category),
                SizedBox(width: 20.0),
                makeButton(kind: FilterType.ingredient),
              ]),
              SizedBox(height: 10.0),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                makeButton(kind: FilterType.glass),
                SizedBox(width: 20.0),
                makeButton(kind: FilterType.alcoholic),
              ]),
            ]),
          ],
        ),
      ),
    );
  }
}
