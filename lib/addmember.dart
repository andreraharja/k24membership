import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_k24_membership/apiK24.dart';
import 'package:flutter_k24_membership/basesession.dart';
import 'package:flutter_k24_membership/sizeconfig.dart';

class AddMembership extends StatefulWidget {
  const AddMembership({Key? key}) : super(key: key);

  @override
  _AddMembershipState createState() => _AddMembershipState();
}

class _AddMembershipState extends State<AddMembership> {
  TextEditingController fieldName = new TextEditingController();
  TextEditingController fieldBirth = new TextEditingController();
  String partnerID = "";
  String partnerCode = "";

  @override
  // ignore: must_call_super
  void initState() {
    initData();
  }

  void initData() async{
    partnerID = await SessionManager.getPartnerId();
    partnerCode = await SessionManager.getPartnerCode();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Membership'),
      ),
      body: Column(
        children: [
          fieldInputName(),
          fieldInputBirth(),
          Container(
              width: SizeConfig.safeBlockHorizontal! * 96,
              child: ElevatedButton(
                  onPressed: () async {
                    String resultAdd = await addMembershipK24(body: {
                      "partnerID": partnerID,
                      "partnerCode": partnerCode,
                      "name": fieldName.text,
                      "dateOfBirth": fieldBirth.text
                    });
                    print(resultAdd);
                    if(resultAdd=="success"){
                      Navigator.pop(context, resultAdd);
                    }
                  },
                  child: Text('Add')))
        ],
      ),
    );
  }

  Widget fieldInputName() {
    return TextFormField(
      controller: fieldName,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        hintText: 'Name',
        contentPadding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal!,
            right: SizeConfig.blockSizeHorizontal!),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.green)),
        fillColor: Colors.grey,
      ),
    );
  }

  Widget fieldInputBirth() {
    return TextFormField(
      controller: fieldBirth,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.date_range,
          color: Colors.green,
        ),
        hintText: 'Date of Birth ex. 1995-11-02',
        contentPadding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal!,
            right: SizeConfig.blockSizeHorizontal!),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.green)),
        fillColor: Colors.grey,
      ),
    );
  }
}
