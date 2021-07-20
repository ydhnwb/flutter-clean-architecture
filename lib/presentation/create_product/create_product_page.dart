import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/product/remote/dto/create_product_request.dart';
import 'package:flutter_clean_architecture/presentation/common/shared_component/primary_button.shared_component.dart';
import 'package:flutter_clean_architecture/presentation/create_product/bloc/create_product_bloc.dart';
import 'package:flutter_clean_architecture/presentation/create_product/bloc/create_product_event.dart';
import 'package:flutter_clean_architecture/presentation/create_product/bloc/create_product_state.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateProductPage extends StatefulWidget {
  final CreateProductPageBloc bloc;
  const CreateProductPage({ Key? key, required this.bloc }) : super(key: key);

  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _inputProductName = TextEditingController();
  final _inputPrice = TextEditingController();
  bool _isLoading = false;

  _handleState(state){
    if(state is CreateProductPageStateIsLoading){
      _isLoading = state.isLoading;
    }else if(state is CreateProductPageStateShowMessage){
      Fluttertoast.showToast(msg: state.message);
    }else if(state is CreateProductPageStateSuccessCreate){
      Navigator.of(context).pop(true);
    }
  }

  _doCreateProduct(){
    if(_formKey.currentState!.validate()){
      String name = _inputProductName.text.toString().trim();
      int price = int.parse(_inputPrice.text.toString().trim());
      CreateProductRequest req = CreateProductRequest(name: name, price: price);
      widget.bloc.add(CreateProductPageEventCreateProduct(createProductRequest: req));
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
              keyboardType: TextInputType.number,
              controller: _inputPrice,
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
              text: "Save",
              onClick: _isLoading ? null : _doCreateProduct,
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create new product"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocConsumer<CreateProductPageBloc, CreateProductPageState>(
              bloc: widget.bloc,
              listener: (context, state) => _handleState(state),
              builder: (context, state){
                return _buildProductForm();
              },
            ),
          )
        ),
      )
    );
  }
}