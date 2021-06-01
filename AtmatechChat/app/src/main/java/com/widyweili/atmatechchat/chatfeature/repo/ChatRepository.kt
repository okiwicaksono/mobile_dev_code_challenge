package com.widyweili.atmatechchat.chatfeature.repo

import com.widyweili.atmatechchat.chatfeature.dao.ChatDaoController
import com.widyweili.atmatechchat.chatfeature.dao.ChatDao
import com.widyweili.atmatechchat.chatfeature.m.Chat

class ChatRepository(val daoController: ChatDaoController) : ChatDao {
    override fun getChats() = daoController.getChats()
    override fun addChat(newChat: Chat) = daoController.addChat(newChat)
    override fun updateChat(refChat: Chat) = daoController.updateChat(refChat)
    override fun addToFirstIndex(newChat: Chat) = daoController.addToFirstIndex(newChat)
    override fun deleteChat(currentChat: Chat) = daoController.deleteChat(currentChat)
    override fun fastDeleteChat(idx: Int) = daoController.fastDeleteChat(idx)
    override fun clearData() = daoController.clearData()

    companion object{
        @Volatile private var instance: ChatRepository? = null
        fun getInstance(daoController: ChatDaoController) = instance
            ?: synchronized(this){
            instance
                ?: ChatRepository(
                    daoController
                )
                    .also { instance = it }
        }
    }
}