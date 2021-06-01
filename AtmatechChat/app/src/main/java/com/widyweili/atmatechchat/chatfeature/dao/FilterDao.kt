package com.widyweili.atmatechchat.chatfeature.dao

import androidx.lifecycle.LiveData
import com.widyweili.atmatechchat.chatfeature.m.Filter

interface FilterDao {
    fun getFilters(): List<Filter>
    fun addFilter(newFilter: Filter)
    fun updateFilter(filterRef: Filter)
    fun resetFilterData()
}