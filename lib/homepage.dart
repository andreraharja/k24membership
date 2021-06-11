import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_k24_membership/addmember.dart';
import 'package:flutter_k24_membership/apiK24.dart';
import 'package:flutter_k24_membership/basesession.dart';
import 'package:flutter_k24_membership/modellogin.dart';
import 'package:flutter_k24_membership/sizeconfig.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MembershipK24> ldMember = [];
  String partnerID = '';
  String partnerCode = '';
  String user = '';

  @override
  // ignore: must_call_super
  void initState() {
    initData();
  }

  void initData() async {
    partnerCode = await SessionManager.getPartnerCode();
    partnerID = await SessionManager.getPartnerId();
    user = await SessionManager.getName();
    ldMember = await getMembershipK24(
        body: {"partnerID": partnerID, "partnerCode": partnerCode});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Membership K24'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: ldMember.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                          ldMember[index].id! + '. ' + ldMember[index].name!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date of Birth : ' +
                              ldMember[index].dateOfBirth!),
                          Text('Registered : ' + ldMember[index].registered!)
                        ],
                      ),
                    );
                  }),
            ),
            user == 'admin1'
                ? Container(
                    width: SizeConfig.safeBlockHorizontal! * 95,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        onPressed: () async {
                          String result = await Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return AddMembership();
                          }));
                          if(result=='Success'){
                            setState(() {

                            });
                          }
                        },
                        child: Text('Add Membership')))
                : Container()
          ],
        ));
  }
}
