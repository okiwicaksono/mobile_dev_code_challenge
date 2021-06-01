package com.widyweili.atmatechchat.chatfeature.dao

import com.widyweili.atmatechchat.chatfeature.m.Filter

class FilterDaoController :
    FilterDao {
    private val _models = mutableListOf<Filter>()

    override fun addFilter(newFilter: Filter) { _models.add(newFilter) }
    override fun getFilters(): List<Filter> = _models
    override fun updateFilter(filterRef: Filter) {
        _models.forEach {
            if(it.filterTitle==filterRef.filterTitle){
                it.flag = filterRef.flag
                return
            }
        }
    }
    override fun resetFilterData() = _models.forEach { it.flag = false }
}