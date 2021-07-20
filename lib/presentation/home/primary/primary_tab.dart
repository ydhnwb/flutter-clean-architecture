import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/domain/product/entity/product_entity.dart';
import 'package:flutter_clean_architecture/presentation/home/primary/bloc/primary_tab_bloc.dart';
import 'package:flutter_clean_architecture/presentation/home/primary/bloc/primary_tab_event.dart';
import 'package:flutter_clean_architecture/presentation/home/primary/bloc/primary_tab_state.dart';
import 'package:flutter_clean_architecture/presentation/home/primary/component/product_item_component.dart';
import 'package:flutter_clean_architecture/presentation/home/primary/primary_tab_router.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PrimaryTab extends StatefulWidget {
  final PrimaryTabBloc primaryTabBloc;


  const PrimaryTab({ Key? key, required this.primaryTabBloc }) : super(key: key);

  @override
  _PrimaryTabState createState() => _PrimaryTabState();
}

class _PrimaryTabState extends State<PrimaryTab> {
  final _products = <ProductEntity>[];
  bool _isLoading = false;

  _fetchProducts(){
    widget.primaryTabBloc.add(PrimaryTabEventGetProducts());
  }

  _handleState(state){
    if(state is PrimaryTabStateLoading){
      _isLoading = state.isLoading;
    }else if(state is PrimaryTabStateShowMessage){
       Fluttertoast.showToast(
        msg: state.message,
        toastLength: Toast.LENGTH_LONG,
      );
    }else if (state is PrimaryTabStateProducts){
      _products.clear();
      _products.addAll(state.products);
    }
  }

  _loadingWidget(){
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _listWidget(){
    return ListView.builder(
      itemCount: _products.length,
      itemBuilder: (context, index) {
        return ProductItem(
          click: () async {
            var isShouldRefresh = await Navigator.pushNamed(context, PrimaryTabRouter.PRIMARY_TAB_DETAIL, arguments: _products[index].id.toString());
            if(isShouldRefresh == true){
              _fetchProducts();
            }
          },
          productEntity: _products[index]
          );
      }
    );
  }


  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: BlocConsumer<PrimaryTabBloc, PrimaryTabState>(
        bloc: widget.primaryTabBloc,
        listener: (context, state) {
          _handleState(state);
        },
        builder: (context, state) {
          return _isLoading ? _loadingWidget() : _listWidget();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var isShouldRefresh = await Navigator.pushNamed(context, PrimaryTabRouter.PRIMARY_TAB_CREATE);
          if(isShouldRefresh == true){
            _fetchProducts();
          }
        },
        child: Icon(Icons.add),
      ),
      
    );
  }
}