package com.widyweili.atmatechchat.chatfeature.adapters

import androidx.recyclerview.widget.DiffUtil
import com.widyweili.atmatechchat.chatfeature.m.Chat

class ChatDiffUtil(private val oldList: List<Chat>, private val newList: List<Chat>) : DiffUtil.Callback() {
    override fun getOldListSize(): Int = oldList.size

    override fun getNewListSize(): Int =newList.size

    override fun areItemsTheSame(oldItemPosition: Int, newItemPosition: Int): Boolean = oldList[oldItemPosition].id==newList[newItemPosition].id

    override fun areContentsTheSame(oldItemPosition: Int, newItemPosition: Int): Boolean {
        return when{
            oldList[oldItemPosition].id != newList[newItemPosition].id->false
            oldList[oldItemPosition].body != newList[newItemPosition].body->false
            oldList[oldItemPosition].attachment != newList[newItemPosition].attachment->false
            oldList[oldItemPosition].timestamp != newList[newItemPosition].timestamp->false
            oldList[oldItemPosition].from != newList[newItemPosition].from->false
            oldList[oldItemPosition].to != newList[newItemPosition].to->false
            oldList[oldItemPosition].sender != newList[newItemPosition].sender->false
            oldList[oldItemPosition].startSearchTs != newList[newItemPosition].startSearchTs->false
            oldList[oldItemPosition].endSearchTs != newList[newItemPosition].endSearchTs->false
            oldList[oldItemPosition].isFirstDay != newList[newItemPosition].isFirstDay->false
            oldList[oldItemPosition].isYesterday != newList[newItemPosition].isYesterday->false
            oldList[oldItemPosition].resources != newList[newItemPosition].resources->false
            else->true
        }
    }
}