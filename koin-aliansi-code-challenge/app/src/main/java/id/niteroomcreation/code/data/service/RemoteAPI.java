package id.niteroomcreation.code.data.service;

import id.niteroomcreation.code.BuildConfig;
import id.niteroomcreation.code.domain.model.DataResponse;
import retrofit2.Call;
import retrofit2.http.GET;

/**
 * Created by Septian Adi Wijaya on 12/08/2022.
 * please be sure to add credential if you use people's code
 */
public interface RemoteAPI {

    @GET(BuildConfig.BASE_PATH)
    Call<DataResponse> getDataMessages();
}
