//Imports //<>//
import java.net.*;
import java.io.BufferedReader;
import java.io.InputStreamReader;

class HttpHelper {
  String baseUrl;
  ArrayList<String[]> params;

  HttpHelper(String _baseUrl) {
    baseUrl = _baseUrl;
    params = new ArrayList<String[]>();
    clearParams();
  }
  HttpHelper(String _baseUrl, String[] _param) {
    baseUrl = _baseUrl;
    params = new ArrayList<String[]>();
    clearParams();
    this.addParam(_param[0], _param[1]);
  }
  HttpHelper(String _baseUrl, ArrayList<String[]> _params) {
    baseUrl = _baseUrl;
    params = new ArrayList<String[]>();
    clearParams();
    params = _params;
  }

  void clearParams() {
    params.clear();
  }

  void addParam(String _key, String _value) {
    try {
      String val = URLEncoder.encode(_value, "UTF-8");
      String[] p = {"", ""};
      p[0] = _key;
      p[1] = val;
      params.add(p);
    } 
    catch(Exception e) {
      println(e.toString());
      println("Param may not have been added");
    }
  }

  String doRequest() {
    //Start processing request, init vars
    System.out.println("Processing request...");
    String requestURL = baseUrl;
    String result = "";

    //Handle params
    if (params.size() > 0) {
      requestURL += "?";
      for (String[] p : params) {
        requestURL += p[0] + "=" + p[1] + "&";
      }
    }

    try {
      //Make URL and con
      URL url = new URL(requestURL);
      log("url = " + requestURL);
      HttpURLConnection con = (HttpURLConnection) url.openConnection();
      con.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36");

      //Tell it to do a get
      con.setRequestMethod("GET");

      //Status code
      int status = con.getResponseCode();
      log("Returned " + status);

      //Handle based on code
      if (status == 200) {
        BufferedReader res = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuffer content = new StringBuffer();
        while ((inputLine = res.readLine()) != null) {
          content.append(inputLine);
        }

        if (content.toString().length() < 500) { //<>//
          System.out.println("Got: " + content);
        } else {
          System.out.println("Got a long string in response, probably a webpage, not printing that out. But we have strill got it");
        }

        result = content.toString();

        //Disconnect connection
        con.disconnect();
        System.out.println("Done processing\n");
      } else { //Other error
        System.out.println("Couldn't finish request");
        System.out.println("Status: " + status);
      }
      return result;
    }
    catch(Exception e) {
      //Handle exceptions (badly)
      System.out.println(e.toString());
    }

    //It shouldn't get here but if it does then something went really wrong
    return null;
  }

  void log(String _msg) {
    System.out.println(_msg);
  }
}
