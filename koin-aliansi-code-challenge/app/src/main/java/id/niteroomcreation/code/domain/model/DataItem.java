package id.niteroomcreation.code.domain.model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class DataItem {

    public static final String TAG = DataItem.class.getSimpleName();

    @SerializedName("attachment")
    @Expose
    private String attachment;

    @SerializedName("from")
    @Expose
    private String from;

    @SerializedName("id")
    @Expose
    private long id;

    @SerializedName("to")
    @Expose
    private String to;

    @SerializedName("body")
    @Expose
    private String body;

    @SerializedName("timestamp")
    @Expose
    private String timestamp;

    public String getAttachment() {
        return attachment;
    }

    public String getFrom() {
        return from;
    }

    public long getId() {
        return id;
    }

    public String getTo() {
        return to;
    }

    public String getBody() {
        return body;
    }

    public String getTimestamp() {
        return timestamp;
    }

    @Override
    public String toString() {
        return "DataItem{" +
                "attachment='" + attachment + '\'' +
                ", from='" + from + '\'' +
                ", id=" + id +
                ", to='" + to + '\'' +
                ", body='" + body + '\'' +
                ", timestamp='" + timestamp + '\'' +
                '}';
    }
}