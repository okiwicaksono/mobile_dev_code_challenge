package com.anangsw.chatappschallenge.main

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.anangsw.chatappschallenge.data.dto.BaseResult
import com.anangsw.chatappschallenge.data.repository.ChatRepositoryImpl
import com.anangsw.chatappschallenge.main.model.MessagesUI
import com.anangsw.chatappschallenge.utils.Constant
import com.anangsw.chatappschallenge.utils.DispatchersHelper
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import javax.inject.Inject

class MainViewModel @Inject constructor(
    private val chatRepositoryImpl: ChatRepositoryImpl,
    private val dispatcherHelper: DispatchersHelper
) : ViewModel() {

    private val _state = MutableLiveData<MainViewState>()
    val state get() = _state

    fun getMessages() {
        viewModelScope.launch(dispatcherHelper.dispatcherIO) {
            val messagesResult = chatRepositoryImpl.getMessages()
            messagesResult.collect {
                when (it) {
                    is BaseResult.Success -> {
                        withContext(DispatchersHelper.dispatcherDefault) {
                            groupMessages(it.data.map { message ->
                                MessagesUI(
                                    attachment = message.attachment,
                                    body = message.body,
                                    from = message.from,
                                    id = message.id,
                                    timestamp = message.timestamp,
                                    to = message.to
                                )
                            })
                        }
                    }
                    is BaseResult.Error -> {
                        _state.postValue(MainViewState.GetMessagesFailed(it.message))
                    }
                }
            }
        }
    }

    private fun groupMessages(messages: List<MessagesUI>) {
        val newMessages = mutableListOf<MessagesUI>()
        var i = 0
        var message: MessagesUI?
        var feedType: String?
        while (i < messages.size) {
            message = messages[i]
            feedType = message.getMessageType()

            when (feedType) {
                Constant.FEED_TYPE_IMAGE -> {
                    val images = getImages(messages, i)
                    if (images != null) {
                        message.images = images
                        i += images.size
                    } else {
                        i++
                    }
                }
                Constant.FEED_TYPE_DOCUMENT -> {
                    val documents = getDocuments(messages, i)
                    if (documents != null) {
                        message.documents = documents
                        i += documents.size
                    } else {
                        i++
                    }
                }
                Constant.FEED_TYPE_CONTACT -> {
                    val contacts = getContacts(messages, i)
                    if (contacts != null) {
                        message.contacts = contacts
                        i += contacts.size
                    } else {
                        i++
                    }
                }
                else -> {
                    i++
                }
            }
            newMessages.add(message)
        }
        _state.postValue(MainViewState.GetMessagesSuccess(newMessages.sortedBy { it.timestamp }))
    }

    private fun getImages(messages: List<MessagesUI>, offset: Int): List<MessagesUI>? {
        var i = offset + 1
        while (i < messages.size && messages[i].attachment == Constant.FEED_TYPE_IMAGE && messages[i].from == messages[offset].from) {
            i++
        }
        return if (i - offset < 2) null else messages.subList(offset, i)
    }

    private fun getContacts(messages: List<MessagesUI>, offset: Int): List<MessagesUI>? {
        var i = offset + 1
        while (i < messages.size && messages[i].attachment == Constant.FEED_TYPE_CONTACT && messages[i].from == messages[offset].from) {
            i++
        }
        return if (i - offset < 2) null else messages.subList(offset, i)
    }

    private fun getDocuments(messages: List<MessagesUI>, offset: Int): List<MessagesUI>? {
        var i = offset + 1
        while (i < messages.size && messages[i].attachment == Constant.FEED_TYPE_DOCUMENT && messages[i].from == messages[offset].from) {
            i++
        }
        return if (i - offset < 2) null else messages.subList(offset, i)
    }

}