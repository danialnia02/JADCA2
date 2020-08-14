package models;

import java.net.URL;

import javax.json.JsonObject;

import com.google.gson.JsonParser;
import com.google.gson.JsonElement;
//import com.google.gson.JsonObject;
import java.net.*;
import java.io.*;

public class exchangeRates {

	String url_str = "https://prime.exchangerate-api.com/v5/2864049c6b06741b289bc19f/latest/SGD";

	public double exchangeRates(String rate) {

		try {
			URL url = new URL(url_str);
			HttpURLConnection request2 = (HttpURLConnection) url.openConnection();
			request2.connect();

			// Convert to JSON
			JsonParser jp = new JsonParser();
			JsonElement root = jp.parse(new InputStreamReader((InputStream) request2.getContent()));
			com.google.gson.JsonObject jsonobj = root.getAsJsonObject();

			// Accessing object
			com.google.gson.JsonObject jsonObject = jsonobj.get("conversion_rates").getAsJsonObject();

			String value = (jsonObject.get(rate)).toString();
			double result = Double.parseDouble(value);
			return result;

		} catch (Exception e) {
			System.out.println("error here");
			e.printStackTrace();
		}
		return 0;
	}
}