import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:knowledge_cards/src/data/repositories/data_card_repository.dart';
import 'package:knowledge_cards/src/pages/create_knowledgecard/create_knowledgecard_controller.dart';

class CreateKnowledgeCardScreen extends View {
  @override
  _CreateKnowledgeCardScreenState createState() =>
      _CreateKnowledgeCardScreenState();
}

class _CreateKnowledgeCardScreenState extends ViewState<
    CreateKnowledgeCardScreen, CreateKnowledgeCardController> {
  _CreateKnowledgeCardScreenState()
      : super(CreateKnowledgeCardController(DataCardRepository()));

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Container(
      key: globalKey,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://images.unsplash.com/photo-1489549132488-d00b7eee80f1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=634&q=80"),
              fit: BoxFit.cover)),
      width: size.width,
      height: size.height,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Create a New KnowledgeCard!",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 50.0, right: 50.0),
                child: ControlledWidgetBuilder<CreateKnowledgeCardController>(
                    builder: (context, controller) {
                  return TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter the card name',
                      ),
                      onChanged: (String value) {
                        controller.name = value;
                        if (value != null) {
                          controller.isCreatingFieldsNull = true;
                        } else {
                          controller.isCreatingFieldsNull = false;
                        }
                      });
                }),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 50.0, right: 50.0),
                child: ControlledWidgetBuilder<CreateKnowledgeCardController>(
                    builder: (context, controller) {
                  return TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter the url for card image',
                      ),
                      onChanged: (String value) {
                        controller.imageUrl = value;
                        if (value != null) {
                          controller.isCreatingFieldsNull = true;
                        } else {
                          controller.isCreatingFieldsNull = false;
                        }
                      });
                }),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 50.0, right: 50.0),
                child: ControlledWidgetBuilder<CreateKnowledgeCardController>(
                    builder: (context, controller) {
                  return TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter the description',
                      ),
                      onChanged: (String value) {
                        controller.description = value;
                        if (value != null) {
                          controller.isCreatingFieldsNull = true;
                        } else {
                          controller.isCreatingFieldsNull = false;
                        }
                      });
                }),
              ),
              SizedBox(
                height: 20,
              ),
              ControlledWidgetBuilder<CreateKnowledgeCardController>(
                builder: (context, controller) {
                  if (controller.isCreatingFieldsNull == false) {
                    return Container(
                        child: ElevatedButton(
                      onPressed: null,
                      child: Text("Create"),
                      style: ElevatedButton.styleFrom(primary: Colors.grey),
                    ));
                  } else {
                    return Container(
                        child: ElevatedButton(
                      onPressed: () {
                        controller.createKnowledgeCard();
                      },
                      child: Text("Create"),
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xFFca575e)),
                    ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
