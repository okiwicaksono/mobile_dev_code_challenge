package com.widyweili.atmatechchat.chatfeature.repo

import com.widyweili.atmatechchat.chatfeature.dao.FilterDaoController
import com.widyweili.atmatechchat.chatfeature.dao.FilterDao
import com.widyweili.atmatechchat.chatfeature.m.Filter

class FilterRepository(val daoController: FilterDaoController) : FilterDao {
    override fun getFilters() = daoController.getFilters()
    override fun addFilter(newFilter: Filter) = daoController.addFilter(newFilter)
    override fun updateFilter(filterRef: Filter) = daoController.updateFilter(filterRef)
    override fun resetFilterData() = daoController.resetFilterData()

    companion object{
        @Volatile private var instance: FilterRepository? = null
        fun getInstance(daoController: FilterDaoController) = instance
            ?: synchronized(this){
            instance
                ?: FilterRepository(
                    daoController
                )
                    .also { instance = it }
        }
    }
}