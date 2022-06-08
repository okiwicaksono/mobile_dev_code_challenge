package com.anangsw.chatappschallenge.main

import com.anangsw.chatappschallenge.main.model.MessagesUI

sealed class MainViewState {

    data class GetMessagesSuccess(val messages: List<MessagesUI>): MainViewState()

    data class GetMessagesFailed(val msg: String): MainViewState()

}