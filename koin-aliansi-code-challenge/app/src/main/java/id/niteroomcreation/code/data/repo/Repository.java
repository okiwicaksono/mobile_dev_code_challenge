package id.niteroomcreation.code.data.repo;

import android.content.Context;

import id.niteroomcreation.code.R;
import id.niteroomcreation.code.data.datasource.remote.RemoteDataSource;
import id.niteroomcreation.code.domain.model.DataResponse;
import id.niteroomcreation.code.util.AppExecutor;
import id.niteroomcreation.code.util.CommonUtil;
import id.niteroomcreation.code.util.listener.ResponseListener;

/**
 * Created by Septian Adi Wijaya on 12/08/2022.
 * please be sure to add credential if you use people's code
 */
public class Repository implements RepositoryImpl {

    public static final String TAG = Repository.class.getSimpleName();

    private static Repository INSTANCE;

    private RemoteDataSource remoteDataSource;
    private AppExecutor executor;
    private Context context;

    private Repository(Context context
            , RemoteDataSource remoteDataSource
            , AppExecutor executor) {

        this.remoteDataSource = remoteDataSource;
        this.executor = executor;
        this.context = context;
    }

    public static Repository getInstance(Context context
            , RemoteDataSource remoteDataSource
            , AppExecutor executor) {

        if (INSTANCE == null) {
            synchronized (Repository.class) {
                INSTANCE = new Repository(context
                        , remoteDataSource
                        , executor);
            }
        }

        return INSTANCE;
    }

    @Override
    public void getDataMessages(ResponseListener<DataResponse> mListener) {
        mListener.onLoading();

        if (CommonUtil.isConnectionExist(context)) {
            remoteDataSource.getDataMessages(new ResponseListener<DataResponse>() {
                @Override
                public void onResponse(DataResponse response) {
                    mListener.onResponse(response);
                }

                @Override
                public void onFailure(String message) {
                    mListener.onFailure(message);
                }
            });
        } else
            mListener.onFailure(context.getString(R.string.err_no_net_connection));
    }
}
