package com.anangsw.chatappschallenge.data.repository

import com.anangsw.chatappschallenge.data.dto.BaseResult
import com.anangsw.chatappschallenge.data.dto.Messages
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject

class ChatRepositoryImpl @Inject constructor(
    private val chatRepository: ChatRepository
) {

    suspend fun getMessages(): Flow<BaseResult<List<Messages>>> = chatRepository.getMessages()

}