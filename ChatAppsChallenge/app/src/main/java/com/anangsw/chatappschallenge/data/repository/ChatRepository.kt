package com.anangsw.chatappschallenge.data.repository

import com.anangsw.chatappschallenge.data.dto.BaseResult
import com.anangsw.chatappschallenge.data.dto.Messages
import kotlinx.coroutines.flow.Flow

interface ChatRepository {

    suspend fun getMessages(): Flow<BaseResult<List<Messages>>>

}