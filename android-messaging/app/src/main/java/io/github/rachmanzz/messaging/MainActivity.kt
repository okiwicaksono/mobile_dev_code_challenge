package io.github.rachmanzz.messaging

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.format.DateFormat
import android.util.Log
import android.widget.Toast
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import io.github.rachmanzz.messaging.databinding.ActivityMainBinding
import io.github.rachmanzz.messaging.utils.MessageAdapter
import io.github.rachmanzz.messaging.utils.MessageCollection
import io.github.rachmanzz.messaging.utils.MessageItemOutput
import io.github.rachmanzz.messaging.utils.MessagingAsset
import org.json.JSONArray
import java.util.*
import kotlin.collections.ArrayList

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding

    lateinit var lyManager : RecyclerView.LayoutManager
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        // recycleView setup
        lyManager = LinearLayoutManager(this)
        binding.messageView.layoutManager = lyManager


        populateMessages()
    }

    private fun populateMessages () {
        val messageAsset = MessagingAsset(this, "messagedataset2.json")

        messageAsset.getMessageList()?.apply {
            val messageItemSorted = this.sortedBy { it.timestamp }

            val finalResultMessage = arrayListOf<MessageCollection>()

            // cache message item before pushing to finalResultMessage
            val cacheMessages = arrayListOf<MessageCollection>()


            try {
                Toast.makeText(applicationContext, "size  ${messageItemSorted.size}", Toast.LENGTH_SHORT).show()

                var i = 0
                for (item in messageItemSorted) {
                    val timestamp: Long = item.timestamp.toLong() * 1000
                    val messageDate = Date(timestamp)
                    val stringDate = DateFormat.format("dd-MM-yyyy", messageDate).toString()
                    val outputItem = MessageItemOutput(
                        id = item.id,
                        body = item.body,
                        timestamp = item.timestamp
                    )
                    val collectingMessage = MessageCollection(
                        txtDate = stringDate,
                        attachment = item.attachment,
                        from = item.from,
                        to = item.to,
                        collection = arrayListOf(outputItem)
                    )

                    if (finalResultMessage.isNotEmpty()) {

                        val lastItem = finalResultMessage.last()
                        val lastItemBody: String? = lastItem.collection.last().body

                        // attachment not null, not document, attachment is same with last item, date is same with last item, body is null, and sender message same with last item
                        if (item.attachment != null && item.attachment != "document" && lastItem.attachment == item.attachment && lastItem.txtDate == stringDate && lastItemBody == null && lastItem.from == item.from) {
                            // cache the item
                            cacheMessages.add(collectingMessage)

                            // if looping end inside here
                            if((i+1) == messageItemSorted.size) {
                                val cacheSize = cacheMessages.size
                                // review cache if not empty
                                if (cacheSize >= 1) {
                                    val cacheAttachment = cacheMessages.last().attachment
                                    Log.i("AttactSize", "$cacheAttachment: size is ${cacheMessages.size}")


                                    // check cacheAttachment is image & size same or more then 4 item
                                    // or attachment is contact & size same or more then 2 item
                                    if (cacheAttachment == "image" && cacheSize >= 4 || cacheAttachment == "contact" && cacheSize >= 2) {
                                        val itemCollected = cacheMessages.map {
                                            // get first or last item is always same, because each item only store 1 collection
                                            it.collection.first()
                                        }
                                        // push caches message to last item of finalResultMessage collection that has mapping
                                        finalResultMessage.last().collection.addAll(itemCollected)
                                    } else {
                                        // because the cache does not meet the criteria, push all message to last of finalResultMessage
                                        finalResultMessage.addAll(cacheMessages)
                                    }
                                    // clear all cache message
                                    cacheMessages.clear()
                                }
                            }
                        } else {
                            val cacheSize = cacheMessages.size
                            // review cache if not empty
                            if (cacheSize >= 1) {
                                val cacheAttachment = cacheMessages.last().attachment
                                Log.i("AttactSize", "$cacheAttachment: size is ${cacheMessages.size}")
                                

                                // check cacheAttachment is image & size same or more then 4 item
                                // or attachment is contact & size same or more then 2 item
                                if (cacheAttachment == "image" && cacheSize >= 4 || cacheAttachment == "contact" && cacheSize >= 2) {
                                    val itemCollected = cacheMessages.map {
                                        // get first or last item is always same, because each item only store 1 collection
                                        it.collection.first()
                                    }
                                    // push caches message to last item of finalResultMessage collection that has mapping
                                    finalResultMessage.last().collection.addAll(itemCollected)
                                } else {
                                    // because the cache does not meet the criteria, push all message to last of finalResultMessage
                                    finalResultMessage.addAll(cacheMessages)
                                }
                                // clear all cache message
                                cacheMessages.clear()
                            }

                            finalResultMessage.add(collectingMessage)
                        }


                    } else {
                        Toast.makeText(applicationContext, "id: ${i}", Toast.LENGTH_SHORT).show()
                        finalResultMessage.add(collectingMessage)
                    }
                    i++
                }
                showMessage(finalResultMessage)
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }

    private fun showMessage(messages: ArrayList<MessageCollection>) {
        val adapter = MessageAdapter(this, messages)
        binding.messageView.adapter = adapter
    }
}