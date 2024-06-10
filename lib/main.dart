import 'package:flutter/material.dart';
import 'package:prefferences_project/theme_data.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final themeData = ThemeColorData(sharedPreferences);
  await themeData.loadThemeFromSharedPref();
  runApp(
    ChangeNotifierProvider<ThemeColorData>(
      create: (BuildContext context) => themeData,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeColorData>(context, listen:  false)
      .loadThemeFromSharedPref();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeColorData>(context).themeColor,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text('Theme Choose',style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SwitchListTile(
              
              title: Provider.of<ThemeColorData>(context).isDark
              ?Text("Dark Theme On",style: Theme.of(context).textTheme.titleMedium)
              :Text("Dark Theme Off",style: Theme.of(context).textTheme.titleMedium),
              
              onChanged: (bool newValue){
                Provider.of<ThemeColorData>(context,listen: false).toggleTheme();
              },
              value:  Provider.of<ThemeColorData>(context).isDark,
            ),
            Card(
              child: ListTile(
                title: Text("To Do List",
                style: TextStyle(
                  color: Colors.black,
                ),),
                trailing: Icon(Icons.check_box),
              ),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: (Theme.of(context).elevatedButtonTheme.style?.backgroundColor!),
              ),
                onPressed: () {},
                child: Text("Add",style: Theme.of(context).textTheme.titleMedium),
              ),
          ],
        ),
      ),
    );
  }
}