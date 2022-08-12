package com.takehome.ardziapp

import android.content.Context
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import com.google.gson.Gson
import com.takehome.ardziapp.databinding.ActivityChatBinding
import com.takehome.ardziapp.model.Chat
import com.takehome.ardziapp.model.ListChat


class ChatActivity : AppCompatActivity() {
    private lateinit var binding: ActivityChatBinding
    private lateinit var adapter: ChatAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityChatBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val jsonData = applicationContext.resources.openRawResource(applicationContext.resources.getIdentifier("message_dataset", "raw", applicationContext.packageName)).bufferedReader().use { it.readText() }
        val  tempData = Gson().fromJson(jsonData, ListChat::class.java).data
        initAdapter(this, tempData)
    }

    private fun initAdapter(context: Context?, listData: List<Chat>) {
        adapter = ChatAdapter( listData)
        binding.rvChat.layoutManager = LinearLayoutManager(context)
        binding.rvChat.adapter = adapter
    }
}