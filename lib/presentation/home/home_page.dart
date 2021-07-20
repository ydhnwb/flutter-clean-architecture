import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/data/common/module/shared_pref_module.dart';
import 'package:flutter_clean_architecture/main.dart';
import 'package:flutter_clean_architecture/presentation/common/infra/router.dart';
import 'package:flutter_clean_architecture/presentation/home/primary/primary_tab_router.dart';
import 'package:flutter_clean_architecture/presentation/home/profile/profile_tab.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  //first is primary tab that contains a nested navigatiob
  //second is profile tab without any navigation
  var _tabProperties = [
    GlobalKey<NavigatorState>(),
    null
  ];
  final SharedPreferenceModule pref = sl.get();
  int _selectedIndex = 0;


  @override
  void initState() {
    _checkIsLoggedIn();
    super.initState();
  }

  Widget _buildPrimaryTab(){
    return Offstage(
        offstage: _selectedIndex != 0,
        child: Navigator(
          key: _tabProperties[0],
          initialRoute: PrimaryTabRouter.PRIMARY_TAB_ROOT,
          onGenerateRoute: PrimaryTabRouter.generateRoute,
        ),
      );
  }

  Widget _buildProfileTab(){
    return Offstage(
      offstage: _selectedIndex != 1,
      child: ProfileTab(pref: sl()),
    );
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
    var key = _tabProperties[_selectedIndex];
    if(key != null){
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
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildPrimaryTab(),
            _buildProfileTab()
          ],
        ),
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