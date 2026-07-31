// V28 FINAL - FIREBASE AUTO SCALABLE - HINDI SASABOG KAHIT 1M USERS!
import 'package:cloud_firestore/cloud_firestore.dart';
class FirebaseAutoScalable {
  static final _firestore = FirebaseFirestore.instance;
  static Future<void> init() async {
    _firestore.settings = Settings(persistenceEnabled: true, cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  }
  static CollectionReference getShardedCollection(String base, String userId) {
    final shardId = userId.hashCode % 10;
    return _firestore.collection('${base}_shard_$shardId');
  }
  static Query lazyLoad(Query query, {int limit = 20}) => query.limit(limit);
}
