package id.niteroomcreation.code.domain.interactor;

import id.niteroomcreation.code.data.repo.RepositoryImpl;
import id.niteroomcreation.code.domain.model.DataResponse;
import id.niteroomcreation.code.util.listener.ResponseListener;

/**
 * Created by Septian Adi Wijaya on 16/08/2022.
 * please be sure to add credential if you use people's code
 */
public class MainUseCase {

    public static final String TAG = MainUseCase.class.getSimpleName();

    private RepositoryImpl repository;

    public MainUseCase(RepositoryImpl repository) {
        this.repository = repository;
    }

    public void invoke(ResponseListener<DataResponse> mListener) {
        repository.getDataMessages(new ResponseListener<DataResponse>() {
            @Override
            public void onLoading() {
                mListener.onLoading();
            }

            @Override
            public void onResponse(DataResponse response) {
                mListener.onResponse(response);
            }

            @Override
            public void onFailure(String message) {
                mListener.onFailure(message);
            }
        });
    }
}
