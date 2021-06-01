package com.widyweili.atmatechchat.chatfeature.m

data class Filter(val id: Int,
                  val filterTitle: String,
                  val predicate: ((t: Chat) -> Boolean?)?,
                  val usage: String = "None",
                  val filterType: String = "internal",
                  var flag: Boolean = false)
