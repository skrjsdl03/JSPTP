<%@page import="DAO.FavoriteDAO"%>
<%@ page contentType="application/json; charset=UTF-8" %>
<%@ page import="java.io.*, org.json.*, java.util.*" %>
<%
BufferedReader reader = request.getReader();
StringBuilder jsonBuilder = new StringBuilder();
String line;
while ((line = reader.readLine()) != null) {
  jsonBuilder.append(line);
}
String jsonStr = jsonBuilder.toString();

JSONObject json = new JSONObject(jsonStr);
JSONArray ids = json.getJSONArray("ids");

FavoriteDAO dao = new FavoriteDAO();
boolean allDeleted = true;

for (int i = 0; i < ids.length(); i++) {
  String fId = ids.getString(i);
  if (!dao.deleteCart(Integer.parseInt(fId))) {
    allDeleted = false;
    break;
  }
}

JSONObject result = new JSONObject();
if (allDeleted) {
  result.put("result", "success");
} else {
  result.put("result", "fail");
}
out.print(result.toString());
%>
