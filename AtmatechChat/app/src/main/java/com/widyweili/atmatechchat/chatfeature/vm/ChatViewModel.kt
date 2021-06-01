package com.widyweili.atmatechchat.chatfeature.vm

import androidx.lifecycle.ViewModel

import com.widyweili.atmatechchat.chatfeature.dao.ChatDao
import com.widyweili.atmatechchat.chatfeature.dao.FilterDao
import com.widyweili.atmatechchat.chatfeature.repo.ChatRepository
import com.widyweili.atmatechchat.chatfeature.m.Chat
import com.widyweili.atmatechchat.chatfeature.m.Filter
import com.widyweili.atmatechchat.chatfeature.repo.FilterRepository

class ChatViewModel(private val chatRepo: ChatRepository, private val filterRepository: FilterRepository) : ViewModel(), ChatDao, FilterDao {
    override fun getChats() = chatRepo.getChats()
    override fun addChat(newChat: Chat) = chatRepo.addChat(newChat)
    override fun updateChat(refChat: Chat) = chatRepo.updateChat(refChat)
    override fun addToFirstIndex(newChat: Chat) = chatRepo.addToFirstIndex(newChat)
    override fun deleteChat(currentChat: Chat) = chatRepo.deleteChat(currentChat)
    override fun fastDeleteChat(idx: Int) = chatRepo.fastDeleteChat(idx)
    override fun clearData() =chatRepo.clearData()

    override fun getFilters(): List<Filter> = filterRepository.getFilters()
    override fun addFilter(newFilter: Filter) = filterRepository.addFilter(newFilter)
    override fun updateFilter(filterRef: Filter) = filterRepository.updateFilter(filterRef)
    override fun resetFilterData() = filterRepository.resetFilterData()
}