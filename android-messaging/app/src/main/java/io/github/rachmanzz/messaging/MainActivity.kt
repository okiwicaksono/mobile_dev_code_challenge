package io.github.rachmanzz.messaging


import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.text.format.DateFormat
import android.util.Log
import android.view.View
import android.widget.*
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.setMargins
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import io.github.rachmanzz.messaging.databinding.ActivityMainBinding
import io.github.rachmanzz.messaging.utils.MessageAdapter
import io.github.rachmanzz.messaging.utils.MessageCollection
import io.github.rachmanzz.messaging.utils.MessageItemOutput
import io.github.rachmanzz.messaging.utils.MessagingAsset
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
                        if (item.attachment != null && item.attachment != "document" && lastItem.attachment == item.attachment && lastItem.txtDate == stringDate && lastItemBody == null && item.body == null && lastItem.from == item.from) {
                            // cache the item
                            cacheMessages.add(collectingMessage)

                            // if looping end inside here
                            if((i+1) == messageItemSorted.size) {
                                val cacheSize = cacheMessages.size
                                // review cache if not empty
                                if (cacheSize >= 1) {
                                    val cacheAttachment = cacheMessages.last().attachment

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
        val adapter = MessageAdapter(this, messages) {
            itemClicked(messages.get(it))
        }
        binding.messageView.adapter = adapter
    }

    private fun itemClicked (item: MessageCollection) {
        when(item.attachment) {
            "document" -> {
                val browserIntent = Intent(Intent.ACTION_VIEW, Uri.parse("https://rachmanzz.github.io/assets/assets/example.pdf"))
                startActivity(browserIntent)
            }
            "image" -> {
                if (item.collection.size>=4) {
                    showImageGroup(item)
                }
                else {
                    val browserIntent = Intent(Intent.ACTION_VIEW, Uri.parse("https://rachmanzz.github.io/assets/assets/imageic.png"))
                    startActivity(browserIntent)
                }
            }
            "contact" -> {
                if (item.collection.size>=2) {
                    groupContact(item.collection)
                }
                else {
                    contact(item.collection.first().id)
                }
            }
        }
    }

    private fun imageView (size: Int = 200): ImageView {
        val img = ImageView(this)
        val param = linearParam(size, size)
        param.setMargins(0)
        param.layoutDirection = LinearLayout.VERTICAL
        img.layoutParams = param

        img.setImageResource(R.drawable.ic_image_view)

        return img
    }

    fun itemLinearLayout(): LinearLayout {
        var iLayout = LinearLayout(this)
        iLayout.layoutParams = linearParam()
        iLayout.orientation = LinearLayout.HORIZONTAL
        return iLayout
    }

    // for complecated layout, use RecyclerView or similar
    private fun showImageGroup(item: MessageCollection) {
        val dialog = AlertDialog.Builder(this)
        dialog.setTitle("Daftar gambar")
        dialog.setMessage(null)
        val sv = ScrollView(this)
        val lWrapper = LinearLayout(this)
        lWrapper.layoutParams = linearParam()
        lWrapper.orientation = LinearLayout.VERTICAL

        val listLayout = arrayListOf<LinearLayout>()

        for ((i, _) in item.collection.withIndex()) {
            if (i == 0  || (i%2) == 0) {
                val iLayout = itemLinearLayout()
                iLayout.addView(imageView())
                listLayout.add(iLayout)
            } else {
                val iLayout = listLayout.last()
                iLayout.addView(imageView())
            }

        }

        for (iL in listLayout) {
            lWrapper.addView(iL)
        }

        sv.addView(lWrapper)
        dialog.setView(sv)
        dialog.show()
    }

    private fun contact (id: Int) {
        val dialog = AlertDialog.Builder(this)
        dialog.setMessage("Kontak pengguna id $id")
        dialog.show()
    }
    private fun groupContact(items: ArrayList<MessageItemOutput>) {
        val dialog = AlertDialog.Builder(this)
        val sv = ScrollView(this)
        val lWrapper = LinearLayout(this)
        lWrapper.layoutParams = linearParam()
        lWrapper.orientation = LinearLayout.VERTICAL

        for (item in items) {
            val text = TextView(this)
            text.setText("pengguna dengan id ${item.id}")
            text.setPadding(10, 10, 10, 10)
            lWrapper.addView(text)
        }
        lWrapper.setPadding(10, 10, 10, 10)
        sv.addView(lWrapper)

        dialog.setView(sv)

        dialog.show()



    }

    fun linearParam (
        w: Int =LinearLayout.LayoutParams.WRAP_CONTENT,
        h: Int = LinearLayout.LayoutParams.WRAP_CONTENT,
        margin: MessageAdapter.Margin = MessageAdapter.Margin(0)

    ): LinearLayout.LayoutParams {
        val l = LinearLayout.LayoutParams(w, h)
        val mLeft = if (margin.l != null) margin.l else margin.size
        val mRight = if (margin.r != null) margin.r else margin.size
        val mTop = if (margin.t != null) margin.t else margin.size
        val mBottom = if (margin.b != null) margin.b else margin.size
        l.setMargins(mLeft!!, mTop!!, mRight!!, mBottom!!)
        return l
    }
}