// V28 FINAL - CEO APK - BRENT ONLY
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'vault_triple_lock.dart';
import '../shared/firebase/firebase_auto_scalable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAutoScalable.init();
  runApp(MegaMallCEOApp());
}
class MegaMallCEOApp extends StatefulWidget {
  @override
  _MegaMallCEOAppState createState() => _MegaMallCEOAppState();
}
class _MegaMallCEOAppState extends State<MegaMallCEOApp> {
  bool vaultOpen = false;
  @override
  void initState() { super.initState(); _checkVault(); }
  Future<void> _checkVault() async {
    final canOpen = await VaultTripleLock.canOpenVault();
    setState(() => vaultOpen = canOpen);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Color(0xFF0A0A0A), primaryColor: Color(0xFFFFD700)),
      home: vaultOpen ? CEODashboard() : VaultSetupScreen(),
    );
  }
}
class VaultSetupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text('CEO VAULT - Brent Only - Set PIN + Fingerprint', style: TextStyle(color: Color(0xFFFFD700)))));
}
class CEODashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text('V28 CEO DASHBOARD - VAULT OPEN', style: TextStyle(color: Color(0xFFFFD700), fontSize: 24))));
}
