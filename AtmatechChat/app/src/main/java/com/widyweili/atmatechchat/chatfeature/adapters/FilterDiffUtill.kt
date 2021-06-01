package com.widyweili.atmatechchat.chatfeature.adapters

import androidx.recyclerview.widget.DiffUtil
import com.widyweili.atmatechchat.chatfeature.m.Filter

class FilterDiffUtill(private val oldList: List<Filter>, private val newList: List<Filter>) : DiffUtil.Callback() {
    override fun getOldListSize(): Int = oldList.size

    override fun getNewListSize(): Int = newList.size

    override fun areItemsTheSame(oldItemPosition: Int, newItemPosition: Int): Boolean = oldList[oldItemPosition].id==newList[newItemPosition].id

    override fun areContentsTheSame(oldItemPosition: Int, newItemPosition: Int): Boolean {
        return when{
            oldList[oldItemPosition].id != newList[newItemPosition].id -> false
            oldList[oldItemPosition].filterTitle != newList[newItemPosition].filterTitle -> false
            oldList[oldItemPosition].usage != newList[newItemPosition].usage -> false
            oldList[oldItemPosition].filterType != newList[newItemPosition].filterType -> false
            oldList[oldItemPosition].predicate != newList[newItemPosition].predicate -> false
            oldList[oldItemPosition].flag != newList[newItemPosition].flag -> false
            else->true
        }
    }
}