package org.programmerplanet.ant.taskdefs.jmeter;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import javax.mail.MessagingException;
import java.io.UnsupportedEncodingException;
import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Task;

public class MailTask extends Task {
	
	private String mailAddress=null;
	
	private String mailSubject=null;
	
	private String mailAttachment=null;
	
	private String resultLog=null;
	File resultLogFile;
	File htmlFile;
	
	//jtl文件
	public void setResultLog(String resultLog) {
		this.resultLog = resultLog;
	}

	public String getResultLog() {
		return resultLog;
	}
	
	//邮件主题
	public void setMailSubject(String mailSubject) {
		this.mailSubject = mailSubject;
	}

	public String getMailSubject() {
		return mailSubject;
	}
	
	//附件  html报告文件
	public void setMailAttachment(String mailAttachment) {
		this.mailAttachment = mailAttachment;
	}

	public String getMailAttachment() {
		return mailAttachment;
	}
	
	//收件地址，多个逗号（英文）隔开
	public void setMailAddress(String mailAddress) {
		this.mailAddress = mailAddress;
	}

	public String getMailAddress() {
		return mailAddress;
	}
	
	/**
	 * @see org.apache.tools.ant.Task#execute()
	 * task执行的入口
	 */
	public void execute() throws BuildException {
        System.out.println("开始执行发送邮件task");
        resultLogFile = new File(System.getProperty("user.dir")+resultLog);
		if (mailAddress != null && resultLogFile.exists()){
			
			System.out.println("开始解析resultLog");
			
			try {
				analyseResultLog();
			} catch (MessagingException e) {
				e.printStackTrace();
			}
		}else{System.out.println("resultLog不存在，请检查！");}
	}
	
	/**
	 * 计算统计数据
	 * @throws MessagingException 
	 */
	private void analyseResultLog() throws BuildException, MessagingException {
		
		String htmlString = "<tr valign=\"top\">"
			+ "<th width=\"50%\">接口</th>"
				+ "<th>执行结果</th>"
				+ "<th>执行时间</th>"
			+ "</tr>";
		String time;
		String name;
		int count=0;
		String color;
		String color1="#FFFFFF";
		String color2="#E1F3FE";
		int successnum = 0;
		int failnum = 0;
		try {
			
			FileInputStream fis = new FileInputStream(System.getProperty("user.dir")+resultLog);   
			InputStreamReader isr = new InputStreamReader(fis, "UTF-8");   
			BufferedReader br = new BufferedReader(isr);   
			String line = null;
			while ((line = br.readLine()) != null) {
				if (line.indexOf("<httpSample ") !=-1) {
					count = count +1;
					color = (count%2<1)?color1:color2;
					if (line.indexOf(" s=\"true\"") !=-1) {
						successnum = successnum + 1;
						time = line.split("\"")[1];
						name = line.split("\"")[13];
						htmlString = htmlString +"<tr valign=\"middle\" style=\"background:"+color+";line-height:2em;\">"
					+ "<td align=\"left\">"+name+"</td>"
					+ "<td align=\"center\">成功</td>"
					+ "<td align=\"center\">"+time+"ms</td>"
					+ "</tr>";
					}else{
						failnum = failnum + 1;
						time = line.split("\"")[1];
						name = line.split("\"")[13];
						htmlString = htmlString +"<tr valign=\"middle\" style=\"color:red;background:"+color+";line-height:2em;\">"
					+ "<td align=\"left\">"+name+"</td>"
					+ "<td align=\"center\">失败</td>"
					+ "<td align=\"center\">"+time+"ms</td>"
					+ "</tr>";
					}
				}
			}
			if(successnum+failnum > 0){
				//有http请求才发邮件
				JavaMail.sendMail(successnum+failnum,  successnum, failnum, htmlString, mailSubject, mailAttachment, mailAddress);
		        System.out.println("邮件发送成功");

			}
			br.close();
			isr.close();
			fis.close();
		}catch (IOException e) {
			throw new BuildException("Could not read jmeter resultLog: " + e.getMessage());
		}
	}
	
	//测试
		public static void main(String[] args) throws MessagingException, UnsupportedEncodingException {
			MailTask mt = new MailTask();
			mt.setResultLog("/jtls/网站首页相关接口测试报告.jtl");
			mt.setMailAttachment("/htmls/网站首页相关接口测试报告.html");
			mt.setMailAddress("baozhida@tuniu.com");

			mt.execute();
			
		}
	
}