import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/home/primary/primary_tab_router.dart';

class PrimaryTab extends StatefulWidget {
  const PrimaryTab({ Key? key }) : super(key: key);

  @override
  _PrimaryTabState createState() => _PrimaryTabState();
}

class _PrimaryTabState extends State<PrimaryTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: ElevatedButton(
            onPressed: () => {
              Navigator.pushNamed(context, PrimaryTabRouter.PRIMARY_TAB_DETAIL)
            }, 
            child: Text("My button")
            ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: Icon(Icons.add),
      ),
      
    );
  }
}