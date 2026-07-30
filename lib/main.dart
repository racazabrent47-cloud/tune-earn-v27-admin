// TUNE EARN ADMIN V2 - CEO ONLY
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() async { WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp(); runApp(const AdminV2()); }
class AdminV2 extends StatelessWidget { const AdminV2({super.key}); @override Widget build(BuildContext c){return MaterialApp(title:'CEO ADMIN V2', debugShowCheckedModeBanner:false, theme:ThemeData.dark(), home: const CEODashboard());}}
class CEODashboard extends StatelessWidget { const CEODashboard({super.key}); @override Widget build(BuildContext context){
return Scaffold(appBar: AppBar(title: const Text('👑 CEO ADMIN V2 - KITA MONITOR'), backgroundColor: Colors.amber, foregroundColor: Colors.black),
body: StreamBuilder<DocumentSnapshot>(stream: FirebaseFirestore.instance.collection('admin').doc('stats').snapshots(), builder:(c,snap){
if(!snap.hasData) return const Center(child:CircularProgressIndicator());
var d=(snap.data!.data() as Map<String,dynamic>?)??{};
return ListView(padding: const EdgeInsets.all(16), children:[
Card(color: Colors.amber, child: ListTile(title: const Text('TOTAL USERS', style: TextStyle(color:Colors.black)), trailing: Text('${d['totalUsers']??0}', style: const TextStyle(color:Colors.black,fontSize:24,fontWeight:FontWeight.bold)))),
Card(color: Colors.green, child: ListTile(title: const Text('GIFT COMMISSION 30% - KITA MO'), trailing: Text('₱${(d['giftCommission']??0).toString()}', style: const TextStyle(fontSize:24,fontWeight:FontWeight.bold)))),
Card(color: Colors.orange, child: ListTile(title: const Text('VIRAL POSTS'), trailing: Text('${d['viralPosts']??0}', style: const TextStyle(fontSize:24)))),
Card(color: Colors.red, child: ListTile(title: const Text('PENDING WITHDRAW'), trailing: Text('₱${d['pendingWithdraw']??0}', style: const TextStyle(fontSize:20)))),
const SizedBox(height:20),
ElevatedButton(onPressed:()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>const ViralPostsPage())), child: const Text('VIRAL POSTS MONITOR')),
ElevatedButton(onPressed:()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>const LiveMonitorPage())), child: const Text('LIVE + GIFTS MONITOR')),
ElevatedButton(onPressed:()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>const WithdrawPage())), child: const Text('WITHDRAW APPROVAL')),
]);
}),
);
}
}
class ViralPostsPage extends StatelessWidget{const ViralPostsPage({super.key}); @override Widget build(BuildContext c){return Scaffold(appBar: AppBar(title: const Text('VIRAL POSTS')), body: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('world_feeds_trending').orderBy('viralScore',descending:true).limit(50).snapshots(), builder:(c,s){if(!s.hasData) return const Center(child:CircularProgressIndicator()); return ListView.builder(itemCount:s.data!.docs.length,itemBuilder:(c,i){var d=s.data!.docs[i].data() as Map<String,dynamic>; return ListTile(title:Text(d['title']??'Video'), subtitle:Text('Score:${d['viralScore']} | Cat:${d['category']}'), trailing: Text('Likes:${d['likes']??0}'));});}));}}
class LiveMonitorPage extends StatelessWidget{const LiveMonitorPage({super.key}); @override Widget build(BuildContext c){return Scaffold(appBar: AppBar(title: const Text('LIVE MONITOR')), body: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('live_rooms').where('isLive',isEqualTo:true).snapshots(), builder:(c,s){if(!s.hasData) return const Center(child:CircularProgressIndicator()); return ListView.builder(itemCount:s.data!.docs.length,itemBuilder:(c,i){var d=s.data!.docs[i].data() as Map<String,dynamic>; return ListTile(title:Text('LIVE: ${d['hostId']}'), subtitle:Text('Gifts: ₱${d['gifts']} - Your 30%: ₱${(d['gifts']*0.3).toStringAsFixed(2)}'));});}));}}
class WithdrawPage extends StatelessWidget{const WithdrawPage({super.key}); @override Widget build(BuildContext c){return Scaffold(appBar: AppBar(title: const Text('WITHDRAW')), body: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('withdraws').where('status',isEqualTo:'pending').snapshots(), builder:(c,s){if(!s.hasData) return const Center(child:CircularProgressIndicator()); return ListView.builder(itemCount:s.data!.docs.length,itemBuilder:(c,i){var doc=s.data!.docs[i]; var d=doc.data() as Map<String,dynamic>; return Card(child:ListTile(title:Text('₱${d['amount']} - GCash:${d['gcash']}'), subtitle:Text('User:${d['userId'].toString().substring(0,6)}'), trailing: ElevatedButton(onPressed:()async{await doc.reference.update({'status':'approved'});}, child:const Text('APPROVE'))));});}));}}
