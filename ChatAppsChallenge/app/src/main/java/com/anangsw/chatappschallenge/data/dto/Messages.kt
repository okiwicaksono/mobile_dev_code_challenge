package com.anangsw.chatappschallenge.data.dto

data class Messages(
    val attachment: String?,
    val body: String?,
    val from: String,
    val id: Int,
    val timestamp: String,
    val to: String,
)