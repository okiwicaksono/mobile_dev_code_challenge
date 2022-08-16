package id.niteroomcreation.code.presentation.feature.main;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;

import id.niteroomcreation.code.data.service.Resource;
import id.niteroomcreation.code.domain.interactor.MainUseCase;
import id.niteroomcreation.code.domain.model.DataResponse;
import id.niteroomcreation.code.presentation.base.BaseViewModel;
import id.niteroomcreation.code.util.listener.ResponseListener;
import id.niteroomcreation.code.util.listener.ViewModelListener;

/**
 * Created by Septian Adi Wijaya on 12/08/2022.
 * please be sure to add credential if you use people's code
 */
public class MainViewModel extends BaseViewModel {

    public static final String TAG = MainViewModel.class.getSimpleName();

    private MainUseCase mainUseCase;
    private MainListener vmListener;

    private MutableLiveData<Resource<DataResponse>> dataMessage = new MutableLiveData<>();

    public MainViewModel(MainUseCase mainUseCase) {
        this.mainUseCase = mainUseCase;
    }

    public void setVmListener(MainListener vmListener) {
        this.vmListener = vmListener;
    }

    public LiveData<Resource<DataResponse>> getMessages() {
        return dataMessage;
    }

    protected void getDataMessages() {
        mainUseCase.invoke(new ResponseListener<DataResponse>() {
            @Override
            public void onLoading() {
                dataMessage.postValue(Resource.loading(null));
            }

            @Override
            public void onResponse(DataResponse response) {
                dataMessage.postValue(Resource.success(response));
            }

            @Override
            public void onFailure(String message) {
                dataMessage.postValue(Resource.error(message, null));
            }
        });
    }

    public interface MainListener extends ViewModelListener {

    }

}
