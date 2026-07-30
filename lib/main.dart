import 'package:flutter/material.dart';
void main() => runApp(const TuneEarnAdmin());
class TuneEarnAdmin extends StatelessWidget {
  const TuneEarnAdmin({super.key});
  @override Widget build(BuildContext c) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: const AdminHome());
  }
}
class AdminHome extends StatefulWidget {
  const AdminHome({super.key});
  @override State<AdminHome> createState() => _AdminHomeState();
}
class _AdminHomeState extends State<AdminHome> {
  int idx = 0;
  final pages = [const DashboardPage(), const ViralPage(), const UsersPage(), const WithdrawPage()];
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('👑 TUNE EARN CEO ADMIN'), backgroundColor: Colors.amber, foregroundColor: Colors.black),
      body: pages[idx],
      bottomNavigationBar: BottomNavigationBar(currentIndex: idx, onTap: (i)=>setState(()=>idx=i), type: BottomNavigationBarType.fixed, selectedItemColor: Colors.amber, items: const [BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'), BottomNavigationBarItem(icon: Icon(Icons.local_fire_department), label: 'Viral'), BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'), BottomNavigationBarItem(icon: Icon(Icons.payments), label: 'Withdraw')]),
    );
  }
}
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override Widget build(BuildContext c) {
    return ListView(padding: const EdgeInsets.all(16), children: [Card(color: Colors.amber, child: ListTile(title: const Text('TOTAL USERS'), trailing: const Text('1,245', style: TextStyle(fontSize: 22)))), Card(color: Colors.green, child: ListTile(title: const Text('GIFT 30% - KITA MO'), trailing: const Text('₱12,450', style: TextStyle(fontSize: 22)))), Card(child: ListTile(title: const Text('VIRAL TODAY'), trailing: const Text('23 posts'))), Card(child: ListTile(title: const Text('PENDING WITHDRAW'), trailing: const Text('₱5,200')))]);
  }
}
class ViralPage extends StatelessWidget {
  const ViralPage({super.key});
  @override Widget build(BuildContext c) {
    return ListView.builder(padding: const EdgeInsets.all(8), itemCount: 10, itemBuilder: (ctx,i){ return Card(child: ListTile(leading: CircleAvatar(backgroundColor: Colors.red, child: Text('${i+1}')), title: Text('Viral Post #${i+1}'), subtitle: Text('${(i+1)*1250} views')));});
  }
}
class UsersPage extends StatelessWidget {
  const UsersPage({super.key});
  @override Widget build(BuildContext c) {
    return ListView.builder(padding: const EdgeInsets.all(8), itemCount: 20, itemBuilder: (ctx,i){ return Card(child: ListTile(title: Text('user_${i+1}@gmail.com'), subtitle: Text('Coins: ${(i+1)*250}')));});
  }
}
class WithdrawPage extends StatelessWidget {
  const WithdrawPage({super.key});
  @override Widget build(BuildContext c) {
    return ListView.builder(padding: const EdgeInsets.all(8), itemCount: 5, itemBuilder: (ctx,i){ return Card(child: ListTile(title: Text('Withdraw ₱${(i+1)*500}'), subtitle: Text('GCash: 09xxx'), trailing: ElevatedButton(onPressed: (){}, child: const Text('APPROVE'))));});
  }
}
