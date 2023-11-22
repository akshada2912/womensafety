import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'acc.dart';
import '../models/db.dart';
import '../services/db_helper.dart';


Future<String> getUsername() async {
  final lst = await DatabaseHelper.getData();
  return lst[0];
}

Future<String> getPasswordEdit() async {
  final lst = await DatabaseHelper.getData();
  return lst[1];
}

Future<String> getPassword() async {
  final lst = await DatabaseHelper.getData();
  String str = "";
  for (int i = 0; i < lst[1].length; i++) {
    var char = lst[1][i];
    if (i == 0 || i == lst[1].length - 1) {
      str += char;
    } else {
      str += "*";
    }
  }
  // return lst[1][0];
  return str;
}

Future<String> getContact1() async {
  final lst = await DatabaseHelper.getData();
  return lst[2];
}

Future<String> getContact2() async {
  final lst = await DatabaseHelper.getData();
  if (lst[3] == "0") {
    return "-";
  } else {
    return lst[3];
  }
}

Future<String> getContact3() async {
  final lst = await DatabaseHelper.getData();
  if (lst[4] == "0") {
    return "-";
  } else {
    return lst[4];
  }
}


class EditPage extends StatefulWidget {
  final Users? user;
  const EditPage({
    Key?key,
    this.user
  }): super(key:key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
 
  @override

  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final usernameCtrlr = TextEditingController();
    final passwordCtrlr = TextEditingController();
    final contact1Ctrlr = TextEditingController();
    final contact2Ctrlr = TextEditingController();
    final contact3Ctrlr = TextEditingController();
    if(widget.user != null){
      usernameCtrlr.text = widget.user!.username;
      passwordCtrlr.text = widget.user!.password;
      contact1Ctrlr.text = widget.user!.contact1;
    }
    return Scaffold(
      
    
      backgroundColor: const Color.fromARGB(255, 248, 213, 246),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          shadowColor: const Color.fromARGB(255, 229, 12, 120),
          backgroundColor: Colors.pink[200],
          title: const Text('Edit profile'),
        ),
      
        body: Form(
          key: _formKey,
          child: Stack(
          children: <Widget>[
          Container(
          decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                    'https://i.pinimg.com/564x/cd/a8/6c/cda86c4d71b9ce823c74a98ed167d5eb.jpg'),
            fit: BoxFit.cover,
            ),),),
          SingleChildScrollView(
        child: Container(
          
          //color: const Color.fromARGB(255, 248, 213, 246),
          padding: const EdgeInsets.all(55.0),
          child:Container(
            padding: const EdgeInsets.all(12.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              TextField(
              controller: usernameCtrlr,

              decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: 'Username',
            hintStyle: TextStyle(color: Colors.grey[500])),
            ),
            const SizedBox(height: 16.0),
           /*const TextField(
              
              decoration: InputDecoration(
                labelText: 'Password',
                border: UnderlineInputBorder(),
                labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20.0),

              ),
              obscureText: true,
           ),*/
             FancyPasswordField(
               controller: passwordCtrlr,
              decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: 'Password',
            hintStyle: TextStyle(color: Colors.grey[500])),
                validationRules: {
                    DigitValidationRule(),
                    UppercaseValidationRule(),
                    LowercaseValidationRule(),
                    SpecialCharacterValidationRule(),
                    MinCharactersValidationRule(6),
                    MaxCharactersValidationRule(12),
                },
                strengthIndicatorBuilder: (strength) => Text(
                  strength.toString(),
                ),
                validationRuleBuilder: (rules, value) {
                  if (value.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return ListView(
                    shrinkWrap: true,
                    children: rules
                        .map(
                          (rule) => rule.validate(value)
                              ? Row(
                                  children: [
                                    const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                        rule.name,
                                        style: const TextStyle(
                                            color: Colors.green,
                                        ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                        rule.name,
                                        style: const TextStyle(
                                            color: Colors.red,
                                        ),
                                    ),
                                  ],
                                ),
                        )
                        .toList(),
                  );
                },
                  
              ),
           
            const SizedBox(height: 16.0),
             FancyPasswordField(
                      controller: contact1Ctrlr,
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'First Contact',
                          hintStyle: TextStyle(color: Colors.grey[500])),
                      validationRules: {
                        DigitValidationRule(),
                        MinCharactersValidationRule(10),
                        MaxCharactersValidationRule(10),
                      },
                      strengthIndicatorBuilder: (strength) => Text(
                            strength.toString(),
                          ),
                      validationRuleBuilder: (rules, value) {
                        if (value.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return ListView(
                          shrinkWrap: true,
                          children: rules
                              .map(
                                (rule) => rule.validate(value)
                                    ? Row(
                                        children: [
                                          const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            rule.name,
                                            style: const TextStyle(
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            rule.name,
                                            style: const TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                              )
                              .toList(),
                        );
                      }),
            const SizedBox(height: 16.0),
             FancyPasswordField(
                      controller: contact2Ctrlr,
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Second Contact',
                          hintStyle: TextStyle(color: Colors.grey[500])),
                      validationRules: {
                        DigitValidationRule(),
                        MinCharactersValidationRule(10),
                        MaxCharactersValidationRule(10),
                      },
                      strengthIndicatorBuilder: (strength) => Text(
                            strength.toString(),
                          ),
                      validationRuleBuilder: (rules, value) {
                        if (value.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return ListView(
                          shrinkWrap: true,
                          children: rules
                              .map(
                                (rule) => rule.validate(value)
                                    ? Row(
                                        children: [
                                          const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            rule.name,
                                            style: const TextStyle(
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            rule.name,
                                            style: const TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                              )
                              .toList(),
                        );
                      }),
            const SizedBox(height: 16.0,),
             FancyPasswordField(
                      controller: contact3Ctrlr,
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Tihrd Contact',
                          hintStyle: TextStyle(color: Colors.grey[500])),
                      validationRules: {
                        DigitValidationRule(),
                        MinCharactersValidationRule(10),
                        MaxCharactersValidationRule(10),
                      },
                      strengthIndicatorBuilder: (strength) => Text(
                            strength.toString(),
                          ),
                      validationRuleBuilder: (rules, value) {
                        if (value.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return ListView(
                          shrinkWrap: true,
                          children: rules
                              .map(
                                (rule) => rule.validate(value)
                                    ? Row(
                                        children: [
                                          const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            rule.name,
                                            style: const TextStyle(
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            rule.name,
                                            style: const TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                              )
                              .toList(),
                        );
                      }),
            const SizedBox(height: 16.0),


            ElevatedButton(
              onPressed: () async {
                      final username = usernameCtrlr.value.text;
                      final password = passwordCtrlr.value.text;
                      final contact1 = contact1Ctrlr.value.text;
                      final contact2 = contact2Ctrlr.value.text;
                      final contact3 = contact3Ctrlr.value.text;

                      if (username.isEmpty || password.isEmpty || contact1.isEmpty) {
                        return;
                      }
                      

                      if(widget.user == null){

                        if(contact2.isEmpty && contact3.isNotEmpty)
                        {
                          final lst = List<String>.filled(5, "0");
                          lst[0]=username;
                          lst[1]=password;
                          lst[2]=contact1;
                          lst[3]="0";
                          lst[4]=contact3;
                          await DatabaseHelper.updateUser(lst);
                        }
                        else if(contact3.isEmpty && contact2.isNotEmpty)
                        {
                          final lst = List<String>.filled(5, "0");
                          lst[0]=username;
                          lst[1]=password;
                          lst[2]=contact1;
                          lst[3]=contact2;
                          lst[4]="0";
                          await DatabaseHelper.updateUser(lst);
                        }
                        else if(contact2.isEmpty && contact3.isEmpty)
                        {
                          final lst = List<String>.filled(5, "0");
                          lst[0]=username;
                          lst[1]=password;
                          lst[2]=contact1;
                          lst[3]="0";
                          lst[4]="0";
                          await DatabaseHelper.updateUser(lst);
                        }
                        else if(contact2.isNotEmpty && contact3.isNotEmpty)
                        {
                          final lst = List<String>.filled(5, "0");
                          lst[0]=username;
                          lst[1]=password;
                          lst[2]=contact1;
                          lst[3]=contact2;
                          lst[4]=contact3;
                          await DatabaseHelper.updateUser(lst);
                        }

                        
                      }
                      await Future.delayed(const Duration(seconds: 1));
                      if(context.mounted){
                         Navigator.push(context, MaterialPageRoute(builder: (context) => AccountPage()));
                      }
                    },
                
              child: const Text('Edit Profile'),
            ),
          ],
        ),
        ).asGlass(),
        ),
        ),
        ],
        ),
    ),
      
        /*bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.white,
          backgroundColor: Colors.pink,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.pink,
              
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: 'Account',
              backgroundColor: Colors.pink,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
              backgroundColor: Colors.pink,
            ),
            ],
           ),*/

      
    );
  }
}