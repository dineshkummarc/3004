/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author David
 */
public class email {
    public String sendEmail(String to, String subject, String contents) {
        Properties props = System.getProperties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.user", "pollcreator.groupf@gmail.com");
        props.put("mail.smtp.password", "p0llcreat0r");
        props.put("mail.smtp.port", "587"); // 587 is the port number of yahoo mail
        props.put("mail.smtps.auth", "true");

        Session session = Session.getDefaultInstance(props, null);
        MimeMessage message = new MimeMessage(session);
        try {
            message.setFrom(new InternetAddress("pollcreator.groupf@gmail.com"));
        } catch (MessagingException ex) {
            System.out.println(ex);
            return "fail";
        }

        InternetAddress recipientAddress = null;
        try {
            recipientAddress = new InternetAddress(to);
        } catch (AddressException ex) {
            System.out.println(ex);
        }
        try {
            message.addRecipient(Message.RecipientType.TO, recipientAddress);
            message.setSubject(subject);
            message.setText(contents);
            Transport transport = session.getTransport("smtps");
            transport.connect("smtp.gmail.com", "pollcreator.groupf@gmail.com", "p0llcreat0r");
            transport.sendMessage(message, message.getAllRecipients());
            transport.close();
        }
        catch(MessagingException ex) {
            System.out.println(ex);
        }

        return "success";

    }
}
