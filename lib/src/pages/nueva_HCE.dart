// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> keyForm = new GlobalKey();
 TextEditingController  nameCtrl = new TextEditingController();
 TextEditingController  emailCtrl = new TextEditingController();
 TextEditingController  mobileCtrl = new TextEditingController();
 TextEditingController  passwordCtrl = new TextEditingController();
 TextEditingController  repeatPassCtrl = new TextEditingController();

  TextEditingController dateinput = TextEditingController(); 

 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     home: new Scaffold(
       appBar: new AppBar(
         title: const Text('Registrarse'),
       ),
       body: new SingleChildScrollView(
         child: new Container(
           margin: const EdgeInsets.all(60.0),
           child: new Form(
             key: keyForm,
             child: formUI(),
           ),
         ),
       ),
     ),
   );
 }

 formItemsDesign(icon, item) {
   return Padding(
     padding: const EdgeInsets.symmetric(vertical: 7),
     child: Card(child: ListTile(leading: Icon(icon), title: item)),
   );
 }

 String gender = 'hombre';

 Widget formUI() {
   return  Column(
     children: <Widget>[
      formItemsDesign(
           Icons.person,
           TextFormField(
             controller: nameCtrl,
             decoration: const InputDecoration(
               labelText: 'Cédula',
             ),
             validator: validateName,
           )),
       formItemsDesign(
           Icons.person,
           TextFormField(
             controller: nameCtrl,
             decoration: const InputDecoration(
               labelText: 'Nombres',
             ),
             validator: validateName,
           )),
            formItemsDesign(
           Icons.person,
           TextFormField(
             controller: nameCtrl,
             decoration: const InputDecoration(
               labelText: 'Apellidos',
             ),
             validator: validateName,
           )),
            formItemsDesign(
           Icons.work,
           TextFormField(
             controller: nameCtrl,
             decoration: const InputDecoration(
               labelText: 'Ocupación',
             ),
             validator: validateName,
           )),
           
          formItemsDesign(
           null,
           Column(children: <Widget>[
             const Text("Estado civil"),
             RadioListTile<String>(
               title: const Text('Casado'),
               value: 'c',
               groupValue: gender,
               onChanged: (value) {
                 setState(() {
                   gender = value!;
                 });
               },
             ),
             RadioListTile<String>(
               title: const Text('Soltero'),
               value: 's',
               groupValue: gender,
               onChanged: (value) {
                 setState(() {
                   gender = value!;
                 });
               },
             ),
              RadioListTile<String>(
               title: const Text('Unión libre'),
               value: 'u',
               groupValue: gender,
               onChanged: (value) {
                 setState(() {
                   gender = value!;
                 });
               },
             ),
              RadioListTile<String>(
               title: const Text('Viud@'),
               value: 'v',
               groupValue: gender,
               onChanged: (value) {
                 setState(() {
                   gender = value!;
                 });
               },
             ),
           ])),
        
       
       formItemsDesign(
           null,
           Column(children: <Widget>[
             const Text("Genero"),
             RadioListTile<String>(
               title: const Text('Hombre'),
               value: 'hombre',
               groupValue: gender,
               onChanged: (value) {
                 setState(() {
                   gender = value!;
                 });
               },
             ),
             RadioListTile<String>(
               title: const Text('Mujer'),
               value: 'mujer',
               groupValue: gender,
               onChanged: (value) {
                 setState(() {
                   gender = value!;
                 });
               },
             )
           ])),

          formItemsDesign(
           Icons.phone,
           TextFormField(
             controller: mobileCtrl,
               decoration: const InputDecoration(
                 labelText: 'Número de teléfono',
               ),
               keyboardType: TextInputType.phone,
               maxLength: 10,
               validator: validateMobile,)),
        formItemsDesign(
           Icons.home,
           TextFormField(
             controller: passwordCtrl,
             obscureText: true,
             decoration: const InputDecoration(
               labelText: 'Dirección',
             ),
           )),
            
        TextField(
                controller: dateinput, //editing controller of this TextField
                // ignore: prefer_const_constructors
                decoration: InputDecoration( 
                   icon: const Icon(Icons.calendar_today), //icon of text field
                   labelText: "Fecha de nacimiento" //label text of field
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );

                   if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                         dateinput.text = formattedDate; //set output date to TextField value. 
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
        ),



     /*  formItemsDesign(
           Icons.email,
           TextFormField(
             controller: emailCtrl,
               decoration: const InputDecoration(
                 labelText: 'Email',
               ),
               keyboardType: TextInputType.emailAddress,
               maxLength: 32,
               validator: validateEmail,)),
       formItemsDesign(
           Icons.remove_red_eye,
           TextFormField(
             controller: passwordCtrl,
             obscureText: true,
             decoration: const InputDecoration(
               labelText: 'Contraseña',
             ),
           )),
       formItemsDesign(
           Icons.remove_red_eye,
           TextFormField(
             controller: repeatPassCtrl,
             obscureText: true,
             decoration: const InputDecoration(
               labelText: 'Repetir la Contraseña',
             ),
             validator: validatePassword,
           )),*/
   GestureDetector(
   onTap: (){
     save();
   },child: Container(
         margin: const EdgeInsets.all(30.0),
         alignment: Alignment.center,
         decoration: ShapeDecoration(
           shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(30.0)),
           gradient: const LinearGradient(colors: [
             Color(0xFF0EDED2),
             Color(0xFF03A0FE),
           ],
               begin: Alignment.topLeft, end: Alignment.bottomRight),
         ),
         padding: const EdgeInsets.only(top: 16, bottom: 16),
         child: const Text("Guardar",
             style: TextStyle(
                 color: Colors.white,
                 fontSize: 18,
                 fontWeight: FontWeight.w500)),
       ))
     ],
   );
 }



 String? validatePassword(String? value) {
   print("valorrr $value passsword ${passwordCtrl.text}");
   if (value != passwordCtrl.text) {
     return "Las contraseñas no coinciden";
   }
   return null;
 }

 String? validateName(String? value) {
   String pattern = r'(^[a-zA-Z ]*$)';
   RegExp regExp = new RegExp(pattern);
   if (value!.isEmpty) {
     return "El nombre es necesario";
   } else if (!regExp.hasMatch(value)) {
     return "El nombre debe de ser a-z y A-Z";
   }
   return null;
 }

 String? validateMobile(String? value) {
   String patttern = r'(^[0-9]*$)';
   RegExp regExp = new RegExp(patttern);
   if (value!.length == 0) {
     return "El telefono es necesariod";
   } else if (value.length != 10) {
     return "El numero debe tener 10 digitos";
   }
   return null;
 }

 String? validateEmail(String? value) {
   String pattern =
       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
   RegExp regExp = new RegExp(pattern);
   if (value!.isEmpty) {
     return "El correo es necesario";
   } else if (!regExp.hasMatch(value)) {
     return "Correo invalido";
   } else {
     return null;
   }
 }

 save() {
   if (keyForm.currentState!.validate()) {
     print("Nombre ${nameCtrl.text}");
     print("Telefono ${mobileCtrl.text}");
     print("Correo ${emailCtrl.text}");
         keyForm.currentState!.reset();
   }
 }
}