package id.niteroomcreation.code.util;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;

import java.util.Date;

/**
 * Created by Septian Adi Wijaya on 16/08/2022.
 * please be sure to add credential if you use people's code
 */
public class CommonUtil {

    public static boolean isConnectionExist(Context context) {
        ConnectivityManager manager = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);

        // Initialize network info
        NetworkInfo networkInfo = manager.getActiveNetworkInfo();

        // get connection status
        return networkInfo != null && networkInfo.isConnectedOrConnecting();
    }

    public static String dateToStringPattern(Date date) {
        return new DateTime(date).toString(DateTimeFormat.forPattern("dd/MM/yyyy HH:mm"));
    }
}
