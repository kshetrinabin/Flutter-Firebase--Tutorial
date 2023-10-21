



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_project/UI/login_page.dart';
import 'package:firebase_project/Utils/utils.dart';
import 'package:firebase_project/auth/post_data/add_post.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth=FirebaseAuth.instance;

  final ref= FirebaseDatabase.instance.ref('data');

  final searchcontroller=TextEditingController();
  final editcontroller=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Home Screen'),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading:false,
        actions: [
          IconButton(onPressed: (){
            _auth.signOut().then((value){

              Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyLogin()));

            }).onError((error, stackTrace){
              Utils().toastMessage(error.toString());
            });
          }, icon:Icon(Icons.logout_outlined)),
          SizedBox(width: 5),
        ],
      ),
      
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            
            children: [
              SizedBox(height: 10),
              TextFormField(
                controller: searchcontroller,
                decoration: InputDecoration(
                  hintText: 'search',
                  border: OutlineInputBorder(),
                ),
                onChanged: (String value) {
                  setState(() {
                    
                  });
                },
              ),
              SizedBox(height: 15),
              Expanded(
                child: FirebaseAnimatedList(
                  query: ref,
                  itemBuilder: (context, snapshot, animation, index) {
                    final  name= snapshot.child('name').value.toString();
                    if(searchcontroller.text.isEmpty){

                      return Card(
                      elevation: 1,
                      shadowColor: Colors.pinkAccent,
                      color: Colors.blue.shade50,
                      child: ListTile(
                        leading: Text(snapshot.child('id').value.toString(),style: TextStyle(fontSize: 0),),
                        title: Text(snapshot.child('name').value.toString(),),
                        subtitle: Text(snapshot.child('short-describe').value.toString(),),
                        trailing: PopupMenuButton(
                          icon: Icon(Icons.more_vert),
                          itemBuilder: (context)=>
                          [
                            PopupMenuItem(child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                showMyDialog(name,snapshot.child('id').value.toString());

                              },
                              title: Text("Edit"),
                              trailing: Icon(Icons.edit),
                            )),
                            PopupMenuItem(child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                ref.child(snapshot.child('id').value.toString()).remove();
                              },
                              title: Text("Delete"),
                              trailing: Icon(Icons.delete),
                            )),
                          ],
                        ),
                      ),
                    );
                    
                    }
                    else if(name.toLowerCase().contains(searchcontroller.text.toLowerCase().toLowerCase())){
                      return Card(
                      elevation: 1,
                      shadowColor: Colors.pinkAccent,
                       color: Colors.blue.shade50,
                      child: ListTile(
                        leading: Text(snapshot.child('id').value.toString(),style: TextStyle(fontSize: 0),),
                        title: Text(snapshot.child('name').value.toString()),
                        subtitle: Text(snapshot.child('short-describe').value.toString()),
                        
                      ),
                    );

                    }
                    else{
                      return Container();
                    }
                    
                    
                  
                },),
                
              ),
            
            ],
          ),
        ),

         floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> addPost()) );
         },
         
         child: Icon(Icons.add),
         ),
         
        
      
    );

  
  }
  Future<void> showMyDialog(String name, String id) async{
editcontroller.text=name;
 return showDialog(context:context, 
 builder: (BuildContext context){
   return AlertDialog(
    title: Text("Update"),
    content: Container(
      child: TextField(
        controller: editcontroller,
        decoration: InputDecoration(
          hintText: 'Edit here',

        ),
      ),
     
      
    ),
    actions: [
      TextButton(onPressed: (){
        Navigator.pop(context);
      }, child:Text("Cancel")),
      TextButton(onPressed: (){
        Navigator.pop(context);
        ref.child(id).update({
          'name':editcontroller.text.toLowerCase(),
        });
      }, child:Text("Update"))
    ],
   );
 });

}
}



