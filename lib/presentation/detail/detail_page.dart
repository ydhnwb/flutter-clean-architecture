import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/product/remote/dto/update_product_request.dart';
import 'package:flutter_clean_architecture/domain/product/entity/product_entity.dart';
import 'package:flutter_clean_architecture/presentation/common/shared_component/danger_button.shared_component.dart';
import 'package:flutter_clean_architecture/presentation/common/shared_component/primary_button.shared_component.dart';
import 'package:flutter_clean_architecture/presentation/detail/bloc/detail_product_bloc.dart';
import 'package:flutter_clean_architecture/presentation/detail/bloc/detail_product_event.dart';
import 'package:flutter_clean_architecture/presentation/detail/bloc/detail_product_state.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailPage extends StatefulWidget {
  final DetailProductPageBloc bloc;
  final String productId;
  const DetailPage({ Key? key, required this.bloc, required this.productId }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _inputProductName = TextEditingController();
  final _inputPrice = TextEditingController();
  bool _isLoading = true;
  ProductEntity? _productEntity;


  _fetchProductById(){
    widget.bloc.add(DetailProductPageEventFindProductById(id: widget.productId));
  }

  _updateInputController(){
    if(_productEntity != null){
      _inputProductName.text = _productEntity!.name;
      _inputPrice.text = _productEntity!.price.toString();
    }
  }

  _updateProduct(){
    if (_formKey.currentState!.validate()) {
      String name = _inputProductName.text.toString().trim();
      int price = int.parse(_inputPrice.text.toString().trim());
      UpdateProductRequest req = UpdateProductRequest(name: name, price: price);
      widget.bloc.add(DetailProductPageEventUpdateProduct(updateProductRequest:req, id: widget.productId));
    }
  }

  _deleteProduct(){
    widget.bloc.add(DetailProductPageEvenetDeleteById(id: widget.productId));
  }

  _handleState(state){
    if(state is DetailProductPageStateIsLoading){
      _isLoading = state.isLoading;
    }else if(state is DetailProductPageStateReceiveProduct){
      _productEntity = state.productEntity;
      _updateInputController();
    }else if(state is DetailProductPageStateSuccessUpdate){
      Navigator.of(context).pop(true);
    }else if(state is DetailProductPageStateShowMessage){
      Fluttertoast.showToast(
        msg: state.message,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  Widget _buildProductForm(){
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _inputProductName,
              decoration: InputDecoration(
                hintText: "Product name",
              ),
              validator: (value) {
                if(value == null || value.toString().trim().isEmpty){
                  return "Product name must not be empty";
                }
                return null;
              },
            ),

            SizedBox(height: 16),

            TextFormField(
              controller: _inputPrice,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Price",
              ),
              validator: (value) {
                if(value == null || value.toString().trim().isEmpty){
                  return "Price must not be empty";
                }
                return null;
              },
            ),

            SizedBox(height: 16),

            PrimaryButton(
              text: "Save changes",
              onClick: _isLoading ? null : _updateProduct,
            ),

            SizedBox(height: 16,),

            DangerButton(
              onClick: _isLoading ? null : _deleteProduct,
              text: "Delete",
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchProductById();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocConsumer<DetailProductPageBloc, DetailProductPageState>(
              bloc: widget.bloc,
              listener: (context, state) => _handleState(state),
              builder: (context, state) {
                return _buildProductForm();
              },
            ),
          ),
        ),
      )
    );
  }
}