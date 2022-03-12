import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:messaging_app/helpers/time_converter.dart';
import 'package:messaging_app/models/chats/message_model.dart';
import 'package:meta/meta.dart';

part 'get_messages_state.dart';

class GetMessagesCubit extends Cubit<GetMessagesState> {
  GetMessagesCubit() : super(GetMessagesLoading());

  convertDateFromTimetamp(String timestamp){
    return DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp)));
  }

  request()async{
    try{
      await Future.delayed(const Duration(milliseconds: 500));
      //read json file
      final jsondata = await rootBundle.loadString('json/message_dataset.json');
      //decode json data as list
      final allMessage = MessagesResponse.fromRawJson(jsondata).data;
      List<List<MessageModel>> groupMessages = [];
      
      List<MessageModel> tempGroups = [];
      String? attachmentName = '';
      for (int i = 0; i < allMessage.length; i++) {
        final message = allMessage[i];
        //for the first index it must insert to tempgroups directly
        if(i == 0){
          tempGroups.add(message);
        }else{
          var dateNow = TimeConverter.dateWithMonthName(message.timestamp);
          var dateBefore = TimeConverter.dateWithMonthName(allMessage[i-1].timestamp);
          //Check if attachment is image and body is null then data valid to add to tempGroup
          //If attachment is not image then attachment is valid
          bool isValidAttachment = message.attachment!='image' || (message.attachment=='image' && message.body==null);
          //Check if message timestamp and message[i-1] timestamp is same && message attachment same with message[i-1] attachment and same sender then add to tempGroup. 
          if(dateNow==dateBefore && message.attachment == allMessage[i-1].attachment && message.from == allMessage[i-1].from && isValidAttachment){
            attachmentName = message.attachment;
            tempGroups.add(message);
            //if(i is last item then add to group message directly)
            if(i==allMessage.length-1){
              groupMessages.add(tempGroups);
            }
          }else{
            if(tempGroups.isNotEmpty){
              //rules for the same attachment is more than 2 same attachment for all attachment exclude image, image has to has 4 minimum attachment to group
              if((tempGroups.length >=2 && attachmentName!='image') || (tempGroups.length >=4 && attachmentName=='image')){
                groupMessages.add(tempGroups);
              } else {
                for (var item in tempGroups) {
                  groupMessages.add([item]);
                }
              }
              //after add to list message then reset tempgroups and attachment name
              attachmentName = '';
              tempGroups = [];
            }
            //add new message to tempGroups
            attachmentName = message.attachment;
            tempGroups.add(message);
          }
        }
      }
      emit(GetMessagesLoaded(messages: MessagesResponse.fromRawJson(jsondata).data, groupMessages: groupMessages));
    } catch(e){
      emit(GetMessagesError(e.toString()));
    }
  } 
}
