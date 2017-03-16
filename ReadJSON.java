import java.util.LinkedHashMap;

import com.jayway.jsonpath.JsonPath;
import com.jayway.jsonpath.Predicate;

import net.minidev.json.JSONArray;
public class Test {

	public static void main(String[] args) {
		String jsonString = "{a:\"nnnnn\",b:{c:4441,d:dadwadw},e:[f:11,g:22],h:[],i:\"\"}";
		String JsonPath,result,name,tmp;
		int n,m,l,p;

		//jsonString = prev.getResponseDataAsString();
		//log.info("======:"+jsonString);
		m=4;

		JsonPath= "$.data["+m+"].gItems.length()";
		result =Test.readjson(jsonString,JsonPath);
		log.info("======================:"+result);
		l = Integer.parseInt(result);
		n = 0;
		for (int i=0;i<le;i++){
			JsonPath= "$.data["+n1+"].gItems["+i+"]";
			n=i+1;
			name = "mId_1_"+n;
			vars.put(name,mId);
			tmp = vars.get(name);
			log.info("======================:"+tmp);
			
			}
		
		System.out.println(resultString);
	}
	
	public static String readjson(String json, String jsonPath) {
		
		try
		{
			Object value = JsonPath.read(json, jsonPath, new Predicate[0]);
			
			if (value instanceof Integer)
		      {
		        return value.toString();
		      }else if (value instanceof String)
		      {
			        return value.toString();
			  }else if (value instanceof Boolean)
		      {
			        return value.toString();
			  }else if (value instanceof JSONArray)
		      {
				  JSONArray arr = (JSONArray)value;
				  if(!arr.isEmpty()){return arr.toJSONString();}
				  
				  return "";
			  }else if (value instanceof LinkedHashMap)
		      {
			        return value.toString();
			  }else{
				  return "";
		      }
		}
		catch(Exception e){
			return "pathnotfound";
		}
	    
	}
	
}

