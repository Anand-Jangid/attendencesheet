import 'package:intl/intl.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import '../constants.dart';


class ProjectActivity extends StatefulWidget {
  static String id = 'project_activity';
  final int indx;
  final String date;
  final List projects;
  final Function addFunction;

  ProjectActivity({required this.indx, required this.date,required this.addFunction,required this.projects});

  @override
  State<ProjectActivity> createState() => _ProjectActivityState();
}

class _ProjectActivityState extends State<ProjectActivity> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SingleValueDropDownController _name = SingleValueDropDownController();
  TextEditingController description = TextEditingController();
  TextEditingController duration = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
            DateFormat('d MMM EEE')
                .format(DateFormat('MM/dd/y').parse(widget.date)),
            style: Ktextstyledaily),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key:_formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9),
                      child: Text(
                        'PROJECT',
                        style: KtextstyleActivity,
                      )),
                  SizedBox(height: 10),
                  DropDownTextField(

                    textFieldDecoration:InputDecoration(
                      hintText:'Select Project Name' ,
                      hintStyle: KtextstyleActivity,
                      enabledBorder:OutlineInputBorder(
                        borderSide:BorderSide(color: Colors.grey),
                        borderRadius:BorderRadius.circular(10.0)
                      ),
                      focusedBorder:OutlineInputBorder(
                          borderSide:BorderSide(color: Colors.grey),
                          borderRadius:BorderRadius.circular(10.0)
                      )
                    ),
                    controller: _name,
                    clearOption: true,
                    dropdownRadius: 10.0,
                    textStyle:KtextstyleActivity1,
                    listTextStyle:KtextstyleActivity1,
                    dropDownList: const [
                      DropDownValueModel(
                          name: 'Cubastion Consulting Private Limited',
                          value: 'Cubastion Consulting Private Limited'),
                      DropDownValueModel(name: 'Web Dev', value: 'Web Dev')
                    ],
                    onChanged: (val) {},
                  ),
                  SizedBox(height: 20),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9),
                      child: Text(
                        'ACTIVITY DESCRIPTION',
                        style: KtextstyleActivity,
                      )),
                  SizedBox(height: 10),
                  TextFormField(
                    style:KtextstyleActivity1,
                    controller: description,
                    decoration: InputDecoration(

                      hintText: 'Enter Project Description',
                      hintStyle: KtextstyleActivity1,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9),
                      child: Text(
                        'ACTIVITY DURATION',
                        style: KtextstyleActivity,
                      )),
                  SizedBox(height: 10),
                  TextFormField(
                    style:KtextstyleActivity1,
                    keyboardType:TextInputType.number,
                    controller: duration,
                    decoration: InputDecoration(
                      hintText: 'Enter Number of Hours',
                      hintStyle: KtextstyleActivity1,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ],
              ),
              Row(children: [
                Expanded(
                    flex: 4,
                    child: SizedBox(
                        height: 60,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Card(
                              color: Colors.grey,
                              child: Center(
                                  child: Text(
                                'Cancel',
                                style: Ktextstylecardbutton,
                              ))),
                        ))),
                Expanded(
                    flex: 6,
                    child: SizedBox(
                        height: 60,
                        child: GestureDetector(
                          onTap: () {
                            _formKey.currentState!.validate();
                            bool available = false;

                            if(widget.projects.isEmpty){
                              widget.addFunction([_name.dropDownValue!.value.toString(), description.text, duration.text,widget.date]);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Entry Added")));
                              Navigator.pop(context);
                            }
                            else{
                              /// Checking for availability
                              for(int i=0; i<widget.projects.length; i++){
                                if(_name.dropDownValue!.value.toString() == widget.projects[i]["Project Name"]){
                                  available = true;
                                }
                              }
                              /// if available --> Show snack-bar
                              if(available == true){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Entry Already Exist")));
                              }
                              else{
                                widget.addFunction([_name.dropDownValue!.value.toString(), description.text, duration.text, widget.date]);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Entry  Added")));

                                Navigator.pop(context);
                              }
                            };
                          },
                            child: Card(
                            color: Colors.orangeAccent,
                            child: Center(
                                child: Text(
                                  '+Add',
                                  style: Ktextstylecardbutton,
                                )))
                          )),
                )])
            ],
          ),
        ),
      ),
    );
  }
}
