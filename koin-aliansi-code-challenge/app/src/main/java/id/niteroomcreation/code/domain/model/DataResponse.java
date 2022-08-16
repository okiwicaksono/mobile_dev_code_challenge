package id.niteroomcreation.code.domain.model;

import java.util.List;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class DataResponse{

	public static final String DATA_IMAGE = "image";
	public static final String DATA_CONTACT = "contact";

	@SerializedName("data")
	@Expose
	private List<DataItem> data;

	public List<DataItem> getData(){
		return data;
	}

	@Override
	public String toString() {
		return "DataResponse{" +
				"data=" + data +
				'}';
	}
}