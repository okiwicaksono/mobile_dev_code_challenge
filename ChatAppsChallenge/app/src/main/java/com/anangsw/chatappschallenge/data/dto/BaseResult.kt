package com.anangsw.chatappschallenge.data.dto

sealed class BaseResult<out T: Any> {

    data class Success<out T: Any>(val data: T): BaseResult<T>()

    data class Error(val message: String, val cause: Exception? = null): BaseResult<Nothing>()

}
