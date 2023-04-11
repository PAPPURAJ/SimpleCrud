import 'package:flutter/material.dart';
import 'package:simplecrudapplication/model/accountmodel.dart';
import 'package:simplecrudapplication/urils/mydio.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  AccountModel? account;

  @override
  void initState() {
    super.initState();
    viewAccount((f) {
      setState(() {
        account = AccountModel.fromJson(f.data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile View'),
      ),
      body: account == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
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
                  subtitle: Text(
                      '${account!.firstName ?? ''} ${account!.lastName ?? ''}'),
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
                ListTile(
                  title: const Text('Created by'),
                  subtitle:  Text(account!.createdBy ?? ''),
                ),
                ListTile(
                  title: const Text('Activation status'),
                  subtitle:  Text(account!.activated!? 'True':'False'),
                ),


              ],
            ),
    );
  }
}
