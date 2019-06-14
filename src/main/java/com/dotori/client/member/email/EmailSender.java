package com.dotori.client.member.email;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;

import lombok.extern.log4j.Log4j;

@Log4j
public class EmailSender {
	
	@Autowired
	protected JavaMailSender mailSender;
	public void SendEmail(Email email) throws Exception{
		
		MimeMessage msg = mailSender.createMimeMessage();
		try {
			msg.setSubject(email.getSubject());
			msg.setText(email.getContent());
			msg.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(email.getReceiver()));
		}catch(MessagingException e) {
			log.info("MessagingException");
			e.printStackTrace();
		}
		
		try {
			mailSender.send(msg);
		}catch (MailException e) {
			log.info("MailException ¹ß»ý");
			e.printStackTrace();
		}
	}
}
