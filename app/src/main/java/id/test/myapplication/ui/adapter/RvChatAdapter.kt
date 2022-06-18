package id.test.myapplication.ui.adapter

import android.content.Context
import android.content.Intent
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import id.test.myapplication.R
import id.test.myapplication.model.DataResponse

class RvChatAdapter(private var itemArrayList: List<DataResponse.Data?>,private val mContext: Context):
    RecyclerView.Adapter<RvChatAdapter.ViewHolder>() {

    override fun onCreateViewHolder(viewGroup: ViewGroup, i: Int): ViewHolder {
        val v: View = LayoutInflater.from(viewGroup.context)
            .inflate(R.layout.adapter_view, viewGroup, false)
        return ViewHolder(v)
    }

    override fun onBindViewHolder(viewHolder: ViewHolder, i: Int) {
        Log.e("masukadapter","yes")
        itemArrayList.sortedBy { "timestamp" }
        viewHolder.tvMesagge.text = "This attachment is ${itemArrayList[i]!!.attachment}"
    }

    override fun getItemCount(): Int {
        return itemArrayList.size
    }

    class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val tvMesagge: TextView = itemView.findViewById(R.id.tvMesagge)

    }
}