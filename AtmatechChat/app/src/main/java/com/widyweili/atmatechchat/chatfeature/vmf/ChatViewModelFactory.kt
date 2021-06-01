package com.widyweili.atmatechchat.chatfeature.vmf

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.widyweili.atmatechchat.chatfeature.vm.ChatViewModel
import com.widyweili.atmatechchat.chatfeature.repo.ChatRepository
import com.widyweili.atmatechchat.chatfeature.repo.FilterRepository

@Suppress("UNCHECKED_CAST")
class ChatViewModelFactory(private val chatRepo: ChatRepository, private val filterRepo: FilterRepository) : ViewModelProvider.Factory{
    override fun <T : ViewModel?> create(modelClass: Class<T>): T {
        if(modelClass.isAssignableFrom(ChatViewModel::class.java))
            return ChatViewModel(chatRepo, filterRepo) as T
        throw IllegalArgumentException("ERROR ON ChatViewModelFactory")
    }
}