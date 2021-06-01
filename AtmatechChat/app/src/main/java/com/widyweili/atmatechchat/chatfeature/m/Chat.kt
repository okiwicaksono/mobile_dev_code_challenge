package com.widyweili.atmatechchat.chatfeature.m

import java.util.*

data class Chat(val id: Int,
                val body: String?,
                val attachment: String?,
                val timestamp: Date,
                val from: String,
                val to: String,
                val sender: String = "A",
                var startSearchTs: Long=0L,
                var endSearchTs: Long=0L,
                val resources: List<String>? = null,
                var isFirstDay: Boolean = false,
                var isYesterday: Boolean = false)
