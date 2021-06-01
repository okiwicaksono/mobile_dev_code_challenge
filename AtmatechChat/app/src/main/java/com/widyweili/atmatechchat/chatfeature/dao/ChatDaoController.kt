package com.widyweili.atmatechchat.chatfeature.dao

import com.widyweili.atmatechchat.chatfeature.m.Chat

class ChatDaoController :
    ChatDao {
    private val _models = mutableListOf<Chat>()

    override fun addChat(newChat: Chat){_models.add(newChat)}
    override fun updateChat(refChat: Chat) {
        _models.forEach {
            if(it.id == refChat.id){
                it.startSearchTs = refChat.startSearchTs
                it.endSearchTs = refChat.endSearchTs
                return
            }
        }
    }
    override fun addToFirstIndex(newChat: Chat)=_models.add(0,newChat)
    override fun deleteChat(currentChat: Chat){ _models.remove(currentChat) }
    override fun fastDeleteChat(idx: Int){ _models.removeAt(idx) }
    override fun clearData()=_models.clear()
    override fun getChats(): List<Chat> = _models
}