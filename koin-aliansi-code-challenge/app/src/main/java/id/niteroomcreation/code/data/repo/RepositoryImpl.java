package id.niteroomcreation.code.data.repo;

import id.niteroomcreation.code.domain.model.DataResponse;
import id.niteroomcreation.code.util.listener.ResponseListener;
import retrofit2.Response;

/**
 * Created by Septian Adi Wijaya on 12/08/2022.
 * please be sure to add credential if you use people's code
 */
public interface RepositoryImpl {

    void getDataMessages(ResponseListener<DataResponse> mListener);
}
