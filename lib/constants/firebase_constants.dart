import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../common/widgets/utills.dart';

// for authentication
FirebaseAuth auth = FirebaseAuth.instance;
// for storing
FirebaseFirestore firestore = FirebaseFirestore.instance;

// this is current user

User? currentUser = auth.currentUser;
// creating user detail in firebase
var currentId = currentUser!.uid;
const usersCollection = "users";

// creating prduct in firebase
const productsCollection = 'product';

const cartCollection = 'cart';
const chatCollection = 'chat';
const msgCollection = 'msg';
const orderCollection = 'order';

Utils utils = Utils();
