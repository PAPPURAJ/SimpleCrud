import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:simplecrudapplication/model/accountmodel.dart';
import 'package:hive/hive.dart';
class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  AccountModel? account;

  @override
  void initState() {
    super.initState();
    _fetchAccount();
  }

  void _fetchAccount() async {
    const String apiUrl = 'https://secure-falls-43052.herokuapp.com/api/account';
    final String token = Hive.box("Login").get("Token",defaultValue: "NA");
    final dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await dio.get(apiUrl);
      setState(() {
        account = AccountModel.fromJson(response.data);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile View'),
      ),
      body: account == null
          ? const Center(child: CircularProgressIndicator(),)
          : ListView(
        children: <Widget>[
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 120,
            backgroundImage: NetworkImage(account!.imageUrl ?? ''),
          ),
          const SizedBox(height: 20),
          ListTile(
            title: const Text('Name'),
            subtitle: Text('${account!.firstName ?? ''} ${account!.lastName ?? ''}'),
          ),
          ListTile(
            title: const Text('Email'),
            subtitle: Text(account!.email ?? ''),
          ),
          ListTile(
            title: const Text('Phone'),
            subtitle: Text(account!.phone ?? ''),
          ),
          ListTile(
            title: const Text('Authorities'),
            subtitle: Text(account!.authorities?.join(', ') ?? ''),
          ),
        ],
      ),
    );
  }
}
