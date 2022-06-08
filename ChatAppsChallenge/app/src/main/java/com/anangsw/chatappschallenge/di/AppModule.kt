package com.anangsw.chatappschallenge.di

import com.anangsw.chatappschallenge.data.datasource.ChatRawJsonDataSource
import com.anangsw.chatappschallenge.data.repository.ChatRepositoryImpl
import com.anangsw.chatappschallenge.utils.DispatchersHelper
import dagger.Module
import dagger.Provides
import javax.inject.Singleton

@Module
object AppModule {

    @Provides
    @Singleton
    fun providesDispatcher() = DispatchersHelper

    @Provides
    @Singleton
    fun provideChatRepository(
        chatRawJsonDataSource: ChatRawJsonDataSource
    ) = ChatRepositoryImpl(chatRawJsonDataSource)

}