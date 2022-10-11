package io.github.rachmanzz.messaging.utils

import android.content.Context
import android.graphics.Color
import android.util.LayoutDirection
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.RelativeLayout
import android.widget.TextView
import androidx.core.view.setMargins
import androidx.recyclerview.widget.RecyclerView
import io.github.rachmanzz.messaging.R

class MessageAdapter(val context: Context,val data: ArrayList<MessageCollection>, val clickListener: (position: Int) -> Unit) : RecyclerView.Adapter<MessageAdapter.ViewHolder>() {

    class ViewHolder(view: View): RecyclerView.ViewHolder(view) {
        val container = view.findViewById<LinearLayout>(R.id.container_layout)
        val profile = view.findViewById<ImageView>(R.id.profile)
        val itemWrapper = view.findViewById<LinearLayout>(R.id.wrapper_message_item)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.view_message_item, parent, false);

        return ViewHolder(view)
    }

    override fun getItemCount(): Int = data.size

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val current = data.get(position)
        if(position >= 1) {
            val lastItem = data.get(position-1)
            if (!current.from.equals(lastItem.from)) {
                holder.profile.visibility = View.VISIBLE
            }
        } else {
            holder.profile.visibility = View.VISIBLE
        }

        if (current.from.toString() == "B") {
            holder.container.layoutDirection = View.LAYOUT_DIRECTION_RTL
            if (holder.profile.visibility == View.VISIBLE) {
                holder.profile.setImageResource(R.drawable.ic_baseline_person_m_24)
            }
        }

        if (current.attachment == "contact") {
            if (current.collection.size >= 2) {
                holder.itemWrapper.addView(contact(true))
                val contactText = textView("Ini kontak beberapa orang")
                holder.itemWrapper.addView(contactText)
            } else {
                holder.itemWrapper.addView(contact())
                val contactText = textView("Ini kontak seseorang")
                holder.itemWrapper.addView(contactText)
            }
        } else if (current.attachment == "document") {
            holder.itemWrapper.addView(documentView())
            val contactText = textView("Ini dokumen")
            holder.itemWrapper.addView(contactText)
        } else if (current.attachment == "image") {
            if (current.collection.size >= 4) {
                holder.itemWrapper.addView(groupImage(current.collection))
            } else {
                val lWrapper = LinearLayout(context)
                lWrapper.layoutParams = linearParam()
                lWrapper.orientation = LinearLayout.VERTICAL

                current.collection.get(0).body?.apply {
                    val txt = textView(this)
                    txt.layoutParams = linearParam(w= LinearLayout.LayoutParams.MATCH_PARENT)
                    lWrapper.addView(txt)
                }
                lWrapper.addView(imageView(300))
                holder.itemWrapper.addView(lWrapper)
            }
        } else {
            val myText = textView(current.collection.first().body!!)
            val param = linearParam(margin = Margin(20))
            myText.layoutParams = param
            holder.itemWrapper.addView(myText)

        }

        if (current.attachment != null) {
            holder.itemWrapper.setOnClickListener { clickListener(position) }
        }
    }

    fun contact(isGroup: Boolean = false): ImageView {
        val img = ImageView(context)
        val param = linearParam(100, 100)
        img.layoutParams = param

        if (isGroup) img.setImageResource(R.drawable.ic_group_contact)
        else img.setImageResource(R.drawable.ic_contact)

        return img

    }

    fun documentView (): ImageView {
        val img = ImageView(context)
        val param = linearParam(100, 100)
        img.layoutParams = param

        img.setImageResource(R.drawable.ic_document)

        return img
    }

    fun imageView (size: Int = 200): ImageView {
        val img = ImageView(context)
        val param = linearParam(size, size)
        param.setMargins(0)
        param.layoutDirection = LinearLayout.VERTICAL
        img.layoutParams = param

        img.setImageResource(R.drawable.ic_image_view)

        return img
    }

    fun groupImage (collection: ArrayList<MessageItemOutput>): LinearLayout {
        val lWrapper = LinearLayout(context)
        lWrapper.layoutParams = linearParam()
        lWrapper.orientation = LinearLayout.VERTICAL

        val listLayout = arrayListOf<LinearLayout>()

        for (i in 0..3) {
            if (i == 0  || (i%2) == 0) {
                val iLayout = itemLinearLayout()
                iLayout.addView(imageView())
                listLayout.add(iLayout)
            } else {
                val iLayout = listLayout.last()
                if (i == 3 && collection.size > 4) {
                    // wrapped with Relative layout
                    val ry = RelativeLayout(context)
                    ry.layoutParams = relativeParam(200, 200)
                    ry.addView(imageView())
                    val v = View(context)
                    v.layoutParams = linearParam(w = LinearLayout.LayoutParams.MATCH_PARENT, h = LinearLayout.LayoutParams.MATCH_PARENT)
                    v.setBackgroundColor(Color.parseColor("#BF000000"))
                    ry.addView(v)
                    val txt = TextView(context)
                    val param = relativeParam()
                    param.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM)
                    param.addRule(RelativeLayout.CENTER_HORIZONTAL)
                    txt.text = "5+ more.."
                    txt.layoutParams = param
                    ry.addView(txt)
                    txt.setTextColor(Color.WHITE)
                    iLayout.addView(ry)

                } else {
                    iLayout.addView(imageView())
                }
            }

        }

        for (item in listLayout) {
            lWrapper.addView(item)
        }

        return lWrapper


    }

    fun itemLinearLayout(): LinearLayout {
        var iLayout = LinearLayout(context)
        iLayout.layoutParams = linearParam()
        iLayout.orientation = LinearLayout.HORIZONTAL
        return iLayout
    }

    fun textView (text: String) : TextView {
        val txt = TextView(context)
        txt.text = text
        txt.setTextColor(Color.WHITE)
        txt.setPadding(5,5,5,5)
        return txt
    }

    fun linearParam (
        w: Int =LinearLayout.LayoutParams.WRAP_CONTENT,
        h: Int = LinearLayout.LayoutParams.WRAP_CONTENT,
        margin: Margin = Margin(0)

    ): LinearLayout.LayoutParams {
        val l = LinearLayout.LayoutParams(w, h)
        val mLeft = if (margin.l != null) margin.l else margin.size
        val mRight = if (margin.r != null) margin.r else margin.size
        val mTop = if (margin.t != null) margin.t else margin.size
        val mBottom = if (margin.b != null) margin.b else margin.size
        l.setMargins(mLeft!!, mTop!!, mRight!!, mBottom!!)
        return l
    }
    fun relativeParam (
        w: Int =LinearLayout.LayoutParams.WRAP_CONTENT,
        h: Int = LinearLayout.LayoutParams.WRAP_CONTENT,
        margin: Margin = Margin(0)
    ): RelativeLayout.LayoutParams {
        val r = RelativeLayout.LayoutParams(w, h)
        val mLeft = if (margin.l != null) margin.l else margin.size
        val mRight = if (margin.r != null) margin.r else margin.size
        val mTop = if (margin.t != null) margin.t else margin.size
        val mBottom = if (margin.b != null) margin.b else margin.size
        r.setMargins(mLeft!!, mTop!!, mRight!!, mBottom!!)
        return r

    }

    data class Padding
        (
        val size: Int? = 0,
        var l: Int? = null,
        var r: Int? = null,
        var t: Int? = null,
        var b: Int? = null
    )

    data class Margin
        (
        val size: Int? = 0,
        val l: Int? = null,
        val r: Int? = null,
        val t: Int? = null,
        val b: Int? = null
    )


}