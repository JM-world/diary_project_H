package com.human.project_H.Controller;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.JSONParser;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.maxmind.geoip2.DatabaseReader;
import com.maxmind.geoip2.model.CityResponse;

@Controller
public class WeatherController {
    @Value("${weatherKey}")
    private String weatherKey;

    @GetMapping("/weather")
    public String getWeather(HttpServletRequest request, HttpSession session, Model model) throws Exception {
        ClassPathResource classPathResource = new ClassPathResource("static/mmdb/GeoLite2-City.mmdb");
        InputStream inputStream = classPathResource.getInputStream();

        // IP 주소 가져오기
        String ipAddress = "58.72.151.124";
        		//getIpAddress(request);

        // GeoIP2를 사용하여 위도(lat)와 경도(lon) 구하기
        DatabaseReader reader = new DatabaseReader.Builder(inputStream).build();
        InetAddress ip = InetAddress.getByName(ipAddress);
        CityResponse response = reader.city(ip);
        Double lat = response.getLocation().getLatitude();
        Double lon = response.getLocation().getLongitude();

        // Model에 위도(lat)와 경도(lon) 추가
        model.addAttribute("lat", lat);
        model.addAttribute("lon", lon);

        String apiUrl = "https://api.openweathermap.org/data/2.5/weather"
                + "?lat=" + lat + "&lon=" + lon + "&units=metric"
                + "&appid=" + weatherKey + "&lang=kr";

        URL url = new URL(apiUrl);
        BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream(), "utf-8"));
        StringBuilder sb = new StringBuilder();
        String line = null;

        while ((line = br.readLine()) != null)
            sb.append(line);
        br.close();

        JSONParser parser = new JSONParser();
        JSONObject object = (JSONObject) parser.parse(sb.toString());
        JSONObject weather = (JSONObject) ((JSONArray) object.get("weather")).get(0);
        String desc = (String) weather.get("description");
        String iconCode = (String) weather.get("icon");
        String iconUrl = "http://openweathermap.org/img/w/" + iconCode + ".png";
        JSONObject main = (JSONObject) object.get("main");
        Double temp_ = (Double) main.get("temp");
        String temp = String.format("%.1f", temp_);
        int humidity = Integer.parseInt(main.get("humidity").toString());
        int windSpeed = (int) Math.round(Double.parseDouble(((JSONObject) object.get("wind")).get("speed").toString()));
        String name = (String) object.get("name");
        JSONObject clouds = (JSONObject) object.get("clouds");
        int cloudiness = Integer.parseInt(clouds.get("all").toString());
        Double tempMin = (Double) main.get("temp_min");
        Double tempMax = (Double) main.get("temp_max");

        inputStream.close();

        // Model에 날씨 정보 추가
        model.addAttribute("description", desc);
        model.addAttribute("iconUrl", iconUrl);
        model.addAttribute("temperature", temp);
        model.addAttribute("name", name);
        model.addAttribute("cloudiness", cloudiness);
        model.addAttribute("humidity", humidity);
        model.addAttribute("temp_max", String.format("%.1f", tempMax));
        model.addAttribute("temp_min", String.format("%.1f", tempMin));
        model.addAttribute("windSpeed", windSpeed);
        model.addAttribute("iconCode", iconCode);
        return "weather"; // View의 이름을 반환
    }

    private String getIpAddress(HttpServletRequest request) {
        String ipAddress = request.getHeader("X-FORWARDED-FOR");

        if (ipAddress == null) {
            ipAddress = request.getRemoteAddr();
        }

        return ipAddress;
    }
}

