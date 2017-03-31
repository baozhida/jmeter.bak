package org.programmerplanet.ant.taskdefs.jmeter;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Properties;
import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage; 

public class JavaMailTask {
	
	static public void sendMail(int all, int successnum, int failnum, String mailSubject, String mailAddress) throws MessagingException {  
		String s;
		DecimalFormat df = new DecimalFormat("0.00");
		
		if(all == 0){
			s = "0";
		} else {
			s = df.format((float)successnum/(float)all*100);
		}
		
		Properties props = new Properties();
		// 开启debug调试
		//props.setProperty("mail.debug", "true");
		// 发送服务器需要身份验证
		props.setProperty("mail.smtp.auth", "false");
		// 设置邮件服务器主机名
		props.setProperty("mail.smtp.host", "mail.tuniu.com");
		// 发送邮件协议名称
		props.setProperty("mail.transport.protocol", "smtp");
	
		// 设置环境信息
		Session session = Session.getInstance(props);
	
		// 创建邮件对象
		Message msg = new MimeMessage(session);
		// 设置主题
		if(mailSubject != null){
			msg.setSubject(mailSubject);
		}else{
			msg.setSubject("接口测试报告");
		}
		// 设置邮件内容
		msg.setContent("<!DOCTYPE html>"
				+ "<html lang=\"en\">"
				+ "<head><META http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">"
				+ "<meta content=\"shanhe.me\" name=\"Author\">"
				+ "<title>JMeter Test Results</title>"
				+ "<style type=\"text/css\">"
				+ "* { margin: 0; padding: 0 }"
				+ "html{ font-size: 12px; margin: auto; }"
				+ "body { width: 60%; margin: 0 auto; text-align:center; }"
				+ "table { border-collapse: collapse; table-layout: fixed;word-wrap:break-word;word-break:break-all; }"
				+ "tr th{border:1px solid black;color: #ffffff;font-weight: bold;text-align:center;background:#2674a6;}"
				+ "td {border:1px solid black; color:red;font-weight:bold;}"
				+ "</style></head></head><body>"
				+ "<h3>接口测试报告概要</h3>"
				+ "<table width=\"100%\"class=\"details\" align=\"center\">"
			+ "<tr valign=\"top\">"
			+ "<th>执行总数</th>"
				+ "<th>成功数</th>"
				+ "<th>失败数</th>"
				+ "<th>成功率</th>"
			+ "</tr>"
			+ "<tr valign=\"top\">"
			+ "<td align=\"center\">"+all+"</td>"
			+ "<td align=\"center\">"+successnum+"</td>"
			+ "<td align=\"center\">"+failnum+"</td>"
			+ "<td align=\"center\">"+s+"%</td>"
			+ "</tr>"
			+ "</table></body></html>", "text/html;charset=utf-8");
		// 设置发件人
		msg.setFrom(new InternetAddress("apiauto@tuniu.com"));
		
		// 设置收件人
			
		@SuppressWarnings("static-access")
		Address[] addresses = new InternetAddress().parse(mailAddress);
		msg.setRecipients(Message.RecipientType.TO,addresses);

		Transport transport = session.getTransport();
		// 连接邮件服务器
		transport.connect();
		// 发送邮件
		Transport.send(msg);
		// 关闭连接
		transport.close();
	} 
	
	//测试
	public static void main(String[] args) throws MessagingException {

		sendMail(5,5,0,"接口报告","baozhida@tuniu.com,tengaiqing@tuniu.com");
	}
}