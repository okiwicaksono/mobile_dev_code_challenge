package id.test.myapplication.ui.main

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import id.test.myapplication.api.Api
import id.test.myapplication.api.Resource
import id.test.myapplication.model.DataResponse
import io.reactivex.disposables.CompositeDisposable

class MainViewModel : ViewModel()  {
    val compositeDisposable = CompositeDisposable()
    val getDataResponse = MutableLiveData<Resource<DataResponse>>()

    fun onDataGet(){
        this.getDataResponse.value = Resource.loading(null)
        val disposable = Api.dataGet().subscribe(this::onSuccessDataGet, this::onErrorDataGet)
        compositeDisposable.add(disposable)
    }

    private fun onSuccessDataGet(nResp: DataResponse){
        this.getDataResponse.value = Resource.success(nResp)
    }

    private fun onErrorDataGet(throwable: Throwable) {
        this.getDataResponse.value = Resource.error(throwable)
    }
}