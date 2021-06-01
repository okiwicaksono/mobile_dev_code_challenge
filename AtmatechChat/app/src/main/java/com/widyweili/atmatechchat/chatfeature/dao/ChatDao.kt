package com.widyweili.atmatechchat.chatfeature.dao

import com.widyweili.atmatechchat.chatfeature.m.Chat

interface ChatDao {
    fun getChats(): List<Chat>
    fun addChat(newChat: Chat)
    fun updateChat(refChat: Chat)
    fun addToFirstIndex(newChat: Chat)
    fun deleteChat(currentChat: Chat)
    fun fastDeleteChat(idx: Int)
    fun clearData()
}