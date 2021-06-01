package com.widyweili.atmatechchat.chatfeature.db

import android.util.Log
import androidx.fragment.app.FragmentActivity
import com.widyweili.atmatechchat.chatfeature.dao.ChatDaoController
import com.widyweili.atmatechchat.chatfeature.m.Chat
import org.json.JSONObject
import java.io.IOException
import java.nio.charset.Charset
import java.util.*

class ChatDatabase {
    val daoController= ChatDaoController()

    companion object{
        @Volatile private var instance: ChatDatabase? = null

        fun getInstance() =
            instance
                ?: synchronized(this){
                instance
                    ?: ChatDatabase()
                        .also { instance = it }
            }
    }

    fun injectJsonData(activity: FragmentActivity){
        try{
            val obj = JSONObject(loadJsonFromAsset(activity)!!)
            val arr = obj.getJSONArray("data")
            for(i in 0 until arr.length()){
                val jsonObj = arr.getJSONObject(i)
                val id = jsonObj.getInt("id")
                val bodyCheck = jsonObj.getString("body")
                val body = if(bodyCheck=="null") null else bodyCheck
                val attachmentCheck = jsonObj.getString("attachment")
                val attachment = if(attachmentCheck=="null") null else attachmentCheck
                val timestamp = jsonObj.getLong("timestamp")*1000L
                val from = jsonObj.getString("from")
                val to = jsonObj.getString("to")
                val newChat = Chat(id,body,attachment,Date(timestamp),from,to)
                daoController.addChat(newChat)
            }
        }catch (e: IOException){
            e.printStackTrace()
        }
    }

    private fun loadJsonFromAsset(activity: FragmentActivity): String? {
        val json: String
        try {
            val dataInput = activity.assets.open("message_dataset.json")
            val size = dataInput.available()
            val buffer = ByteArray(size)
            dataInput.read(buffer)
            dataInput.close()
            json = String(buffer, Charset.defaultCharset())
        }catch (e: IOException){
            e.printStackTrace()
            return null
        }
        return json
    }
}