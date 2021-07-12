import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/data/common/module/shared_pref_module.dart';
import 'package:flutter_clean_architecture/domain/login/entity/login_entity.dart';
import 'package:flutter_clean_architecture/main.dart';
import 'package:flutter_clean_architecture/presentation/common/infra/router.dart';
import 'package:flutter_clean_architecture/presentation/home/primary/primary_tab.dart';
import 'package:flutter_clean_architecture/presentation/home/primary/primary_tab_router.dart';
import 'package:flutter_clean_architecture/presentation/home/profile/profile_tab.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  final List<Widget> _tabs = <Widget>[
      Navigator(
        key: GlobalKey<NavigatorState>(),
        initialRoute: PrimaryTabRouter.PRIMARY_TAB_ROOT,
        onGenerateRoute: PrimaryTabRouter.generateRoute,
      ),
      ProfileTab(),
  ];

  final SharedPreferenceModule pref = sl.get();
  int _selectedIndex = 0;


  @override
  void initState() {
    _checkIsLoggedIn();
    super.initState();
  }


  void _checkIsLoggedIn(){
    if(pref.getUserData().isEmpty){
      _goToLoginPage();
    }
  }

  void _goToLoginPage(){
    Navigator.popAndPushNamed(context, AppRouter.ROUTE_LOGIN);
  }

  void _onBottomNavSelected(index){
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _shouldExitApp() async {
    var key = _tabs[_selectedIndex].key;
    if(key != null){
      key as GlobalKey<NavigatorState>;
      bool shouldNotExitApp = await key.currentState!.maybePop();
      return !shouldNotExitApp;
    }
    return true;

  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return _shouldExitApp();
        // var x = _tabs[_selectedIndex].key! as GlobalKey<NavigatorState>;
        // bool isFirst = await x.currentState!.maybePop();
        // return !isFirst;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Clean architecture"),
        ),
        body: _tabs[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green[600],
          onTap: _onBottomNavSelected,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "Home"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile"
            )
          ],
        ),
      ),
    );
  }
}