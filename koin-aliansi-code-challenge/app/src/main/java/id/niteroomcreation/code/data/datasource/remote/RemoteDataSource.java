package id.niteroomcreation.code.data.datasource.remote;

import android.content.Context;

import id.niteroomcreation.code.data.service.APIService;
import id.niteroomcreation.code.data.service.RemoteAPI;
import id.niteroomcreation.code.domain.model.DataResponse;
import id.niteroomcreation.code.util.AppExecutor;
import id.niteroomcreation.code.util.listener.ResponseListener;
import retrofit2.Response;

/**
 * Created by Septian Adi Wijaya on 12/08/2022.
 * please be sure to add credential if you use people's code
 */
public class RemoteDataSource {

    public static final String TAG = RemoteDataSource.class.getSimpleName();

    private volatile static RemoteDataSource INSTANCE;

    private RemoteAPI remoteApi;
    private AppExecutor mExecutor;
    private Context context;

    private RemoteDataSource() {
    }

    public RemoteDataSource(AppExecutor mExecutor, RemoteAPI remoteApi, Context context) {
        this.remoteApi = remoteApi;
        this.mExecutor = mExecutor;
        this.context = context;
    }

    public static RemoteDataSource getInstance(Context context, AppExecutor mExecutor) {
        if (INSTANCE == null) {
            synchronized (RemoteDataSource.class) {
                INSTANCE = new RemoteDataSource(mExecutor, APIService.createService(context), context);
            }
        }

        return INSTANCE;
    }

    public void getDataMessages(ResponseListener<DataResponse> mListener) {
        mExecutor.networkIO().execute(new Runnable() {
            @Override
            public void run() {
                try {
                    Response<DataResponse> m = remoteApi.getDataMessages().execute();

                    if (m.isSuccessful()) {
                        if (m.body() != null)
                            mListener.onResponse(m.body());
                        else
                            mListener.onFailure(m.errorBody().string());
                    } else
                        mListener.onFailure(String.format("error code %s %s", m.code(), m.message()));
                } catch (Exception e) {
                    e.printStackTrace();

                    mListener.onFailure(e.getMessage());
                }
            }
        });
    }
}
