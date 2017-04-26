package org.programmerplanet.ant.taskdefs.jmeter;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

public class JavaMail {
	
	static File mailAttachmentFile;
	
	static public void sendMail(int all, int successnum, int failnum, String htmlstring, String mailSubject, String mailAttachment, String mailAddress) throws MessagingException, UnsupportedEncodingException {  
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
		
		// 设置发件人
		msg.setFrom(new InternetAddress("apiauto@tuniu.com"));
		
		// 设置收件人
		@SuppressWarnings("static-access")
		Address[] addresses = new InternetAddress().parse(mailAddress);
		msg.setRecipients(Message.RecipientType.TO,addresses);
		// 设置主题
		if(mailSubject != null){
			msg.setSubject(mailSubject);
		}else{
			msg.setSubject("接口测试报告");
		}
		
		// 设置邮件内容
		
		BodyPart bp = new MimeBodyPart();
        Multipart mp = new MimeMultipart();  
		bp.setContent("<!DOCTYPE html>"
				+ "<html lang=\"en\">"
				+ "<head><META http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">"
				+ "<meta content=\"shanhe.me\" name=\"Author\">"
				+ "<title>JMeter Test Results</title>"
				+ "<style type=\"text/css\">"
				+ "* { margin: 0; padding: 0 }"
				+ "html{ font-size: 12px; margin: auto; }"
				+ "body { width: 80%; margin: 0 auto; text-align:center; font-size:62.5%;}"
				+ "table { font-size:12px;border-collapse: collapse; table-layout: fixed;word-wrap:break-word;word-break:break-all; }"
				+ "th{border:1px solid black;color: #ffffff;font-weight: normal;text-align:center;background:#2674a6;}"
				+ "td {border:1px solid black;font-weight:normal;}"
				+ "</style></head></head><body>"
				+ "<h2>接口测试报告概要(详细内容见邮件附件)</h2>"
				+ "<table width=\"100%\"class=\"details\" align=\"center\">"
			+ "<tr style=\"line-height:2em;\" valign=\"middle\">"
			+ "<th width=\"50%\">执行总数</th>"
				+ "<th>失败数</th>"
				+ "<th>成功率</th>"
			+ "</tr>"
			+ "<tr style=\"line-height:2em;\" valign=\"middle\">"
			+ "<td align=\"center\">"+all+"</td>"
			+ "<td align=\"center\">"+failnum+"</td>"
			+ "<td align=\"center\">"+s+"%</td>"
			+ "</tr>"
			+htmlstring
			+ "</table></body></html>", "text/html;charset=utf-8");
		
		mp.addBodyPart(bp);
		
		//附件为空时不发附件
		mailAttachmentFile = new File(System.getProperty("user.dir")+mailAttachment);
		if(mailAttachmentFile.exists()){
			System.out.println("把mailAttachment报告文件作为附件发送");
			bp = new MimeBodyPart();
			FileDataSource fileds = new FileDataSource(System.getProperty("user.dir")+mailAttachment); 
			bp.setDataHandler(new DataHandler(fileds)); 
			bp.setFileName(MimeUtility.encodeText(fileds.getName(),"UTF-8","B"));
			mp.addBodyPart(bp); 
		}else{System.out.println("mailAttachment文件不存在，邮件添加附件失败，请检查！");}
		
		msg.setContent(mp);
		msg.saveChanges(); 

		Transport transport = session.getTransport();
		// 连接邮件服务器
		transport.connect();
		// 发送邮件
		Transport.send(msg);
		// 关闭连接
		transport.close();
	} 
	
	//测试
	public static void main(String[] args) throws MessagingException, UnsupportedEncodingException {
		
		String ContentString = "<tr valign=\"middle\" style=\"line-height:2em;\">"
				+ "<th>接口</th>"
					+ "<th>执行结果</th>"
					+ "<th>执行时间</th>"
				+ "</tr>";
		String ContentString2 = "<tr valign=\"middle\" style=\"color:black;background:#D1F3FE;line-height:2em;\">"
			+ "<td align=\"left\">"+"/portal/home/pc/search/popup报告测试"+"</td>"
			+ "<td align=\"center\">"+"成功"+"</td>"
			+ "<td align=\"center\">"+"100ms"+"</td>"
			+ "</tr>";

		sendMail(5,5,0,ContentString+ContentString2,"/portal/home/pc/search/popup接口报告", "111","baozhida@tuniu.com");
	}
}