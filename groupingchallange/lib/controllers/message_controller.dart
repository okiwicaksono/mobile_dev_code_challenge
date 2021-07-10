import 'dart:convert';

import 'package:get/get.dart';
import 'package:groupingchallange/constants/enum.dart';
import 'package:groupingchallange/models/message_dataset.dart';
import 'package:flutter/services.dart' show rootBundle;

class MessageController extends GetxController {
  List<Message> messages = List<Message>.empty(growable: true);
  List<Message> filteredMessages = List<Message>.empty(growable: true);
  bool loading = false;
  FilterCriteria filterSelected = FilterCriteria.SAME_DATE;
  changeFilterType(val) {
    filterSelected = val;
    filteredByCriteria(filterSelected);
    update();
  }

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<MessagesDataset> parseJsonFromAssets(String assetsPath) async {
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr))
        .then((json) => MessagesDataset.fromJson(json));
  }

  fetchData() async {
    loading = true;
    update();
    final localMessages =
        await parseJsonFromAssets("assets/message_dataset.json");
    messages.addAll(localMessages.data);
    filteredMessages.addAll(localMessages.data);
    loading = false;
    update();
  }

  List<String> categoryName = [];
  List<int> sequence = [];

  AttachmentType? currentActiveTypeFilter;
  bool isImageFilterActive = false;
  bool isContactFilterActive = false;

  resetFilter() {
    filteredMessages.clear();
    filteredMessages.addAll(messages);
    update();
  }

  onChangeTypeFilter(AttachmentType type, bool value) {
    if (type == AttachmentType.CONTACT) {
      isContactFilterActive = value;
    } else if (type == AttachmentType.IMAGE) {
      isImageFilterActive = value;
    }
    update();
  }

  filterByType() {
    loading = true;
    update();

    filteredMessages.clear();
    if (isContactFilterActive) {
      final selected =
          messages.where((element) => element.attachment == "contact").toList();
      filteredMessages.addAll(selected);
    }
    if (isImageFilterActive) {
      final selected =
          messages.where((element) => element.attachment == "image").toList();
      filteredMessages.addAll(selected);
    }

    if (!isContactFilterActive && !isImageFilterActive) {
      filteredMessages.addAll(messages);
    }
    loading = false;

    update();
  }

  filteredByCriteria(FilterCriteria criteria) {
    filterByType();
    categoryName.clear();
    sequence.clear();
    if (criteria == FilterCriteria.SAME_SENDER) {
      categoryName.addAll(sender());
    } else if (criteria == FilterCriteria.SAME_DATE) {
      categoryName.addAll(date());
    } else if (criteria == FilterCriteria.NO_BODY) {
      categoryName = ["empty body", "not empty body"];
    } else if (criteria == FilterCriteria.REPEATED_FOUR_TIMES) {
      searchRepeated("image", 4);
    } else if (criteria == FilterCriteria.REPEATED_TWO_TIMES) {
      searchRepeated("contact", 2);
    }

    update();
  }

  searchRepeated(type, nums) {
    String? prevType;
    // String? sender;
    int count = 1;
    messages.forEach((element) {
      int id = element.id;

      if (prevType == element.attachment && element.attachment == type) {
        count++;
        if (count == nums) {
          if (nums > 3) sequence.add((id - 3));
          if (nums > 2) sequence.add((id - 2));
          sequence.add((id - 1));
          sequence.add(id);
        } else if (count > nums) {
          sequence.add(id);
        }
      } else {
        count = 1;
      }
      prevType = element.attachment;
    });

    int countSequence = 1;
    int prevSequenceValue = -1;

    sequence.asMap().forEach((i, element) {
      if (element - 1 == prevSequenceValue) {
        countSequence++;
      } else {
        if (countSequence >= nums) categoryName.add(countSequence.toString());
        countSequence = 1;
      }
      if (i == sequence.length - 1) {
        if (countSequence >= nums) categoryName.add(countSequence.toString());
      }
      prevSequenceValue = element;
    });
  }

  List<String> sender() {
    Set<String> list = <String>{};
    messages.forEach((element) {
      list.add(element.from);
      list.add(element.to);
    });
    return list.toList();
  }

  List<String> date() {
    Set<String> list = <String>{};
    messages.forEach((element) {
      list.add(element.date);
    });
    return list.toList();
  }
}
