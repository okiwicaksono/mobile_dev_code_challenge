package id.niteroomcreation.code.data.service;

import static id.niteroomcreation.code.util.StatusResponse.EMPTY;
import static id.niteroomcreation.code.util.StatusResponse.ERROR;
import static id.niteroomcreation.code.util.StatusResponse.SUCCESS;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import id.niteroomcreation.code.util.StatusResponse;

/**
 * Created by Septian Adi Wijaya on 12/08/2022.
 * please be sure to add credential if you use people's code
 */
public class ApiResponse<T> {

    @NonNull
    public final StatusResponse status;

    @Nullable
    public final String message;

    @Nullable
    public final T body;

    public ApiResponse(@NonNull StatusResponse status, @Nullable T body, @Nullable String message) {
        this.status = status;
        this.body = body;
        this.message = message;
    }

    public static <T> ApiResponse<T> success(@Nullable T body) {
        return new ApiResponse<>(SUCCESS, body, null);
    }

    public static <T> ApiResponse<T> empty(String msg, @Nullable T body) {
        return new ApiResponse<>(EMPTY, body, msg);
    }

    public static <T> ApiResponse<T> error(String msg, @Nullable T body) {
        return new ApiResponse<>(ERROR, body, msg);
    }

}