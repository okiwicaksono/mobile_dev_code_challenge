package com.widyweili.atmatechchat.chatfeature.db

import com.widyweili.atmatechchat.chatfeature.dao.FilterDaoController
import com.widyweili.atmatechchat.chatfeature.m.Filter

class FilterDatabase {
    val daoController=
        FilterDaoController()

    init {
        daoController.addFilter(Filter(0,"None",null))

        // images filtration
        daoController.addFilter(Filter(1,"Image", { chat -> if(chat.attachment==null) false else chat.attachment.contains("image") }, "image"))
        daoController.addFilter(Filter(2,"Same Sender",{chat -> chat.from==chat.sender}, "image,contact"))
        daoController.addFilter(Filter(3,"Same Day", { chat -> chat.timestamp.time >= chat.startSearchTs &&  chat.timestamp.time <= chat.endSearchTs}, "image,contact"))
        daoController.addFilter(Filter(4,"No Title",{chat->chat.body==null},"image"))
        daoController.addFilter(Filter(5,"Repeated 4 times", null,"image", "external"))

        // contacts filtration
        daoController.addFilter(Filter(6,"Contact",{ chat->if(chat.attachment==null) false else chat.attachment.contains("contact")},"contact"))
        daoController.addFilter(Filter(7,"Repeated 2 times", null,"contact","external"))
    }

    companion object{
        @Volatile private var instance: FilterDatabase? = null

        fun getInstance() =
            instance
                ?: synchronized(this){
                instance
                    ?: FilterDatabase()
                        .also { instance = it }
            }
    }
}