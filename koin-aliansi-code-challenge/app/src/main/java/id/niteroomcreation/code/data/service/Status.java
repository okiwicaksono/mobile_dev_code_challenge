package id.niteroomcreation.code.data.service;

/**
 * Created by monta on 21/12/21
 * please make sure to use credit when using people code
 **/
public class Status {

    public enum Local {
        SUCCESS,
        ERROR,
        LOADING
    }

    public enum Remote {
        SUCCESS,
        EMPTY,
        ERROR
    }
}
