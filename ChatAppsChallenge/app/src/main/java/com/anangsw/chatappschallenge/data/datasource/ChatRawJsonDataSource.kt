package com.anangsw.chatappschallenge.data.datasource

import android.content.Context
import com.anangsw.chatappschallenge.data.dto.BaseResult
import com.anangsw.chatappschallenge.data.dto.ChatModel
import com.anangsw.chatappschallenge.data.dto.Messages
import com.anangsw.chatappschallenge.data.repository.ChatRepository
import com.anangsw.chatappschallenge.utils.DispatchersHelper
import com.google.gson.Gson
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOn
import javax.inject.Inject

class ChatRawJsonDataSource @Inject constructor(
    private val context: Context
) : ChatRepository {

    override suspend fun getMessages(): Flow<BaseResult<List<Messages>>> {
        return flow {
            try {
                val jsonString = context.assets.open("message_dataset.json")
                    .bufferedReader()
                    .use { it.readText() }
                val chatModel = Gson().fromJson(jsonString, ChatModel::class.java)
                emit(BaseResult.Success(chatModel.data))
            } catch (e: Exception) {
                emit(BaseResult.Error(e.message.toString(), e))
            }
        }
    }
}