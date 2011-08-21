package service;


import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import java.util.Properties;

/**
 * A class providing E-mail access with sending E-mail only.
 * @author Andy
 */
public class EmailService {

    private String user;
    // E-mail receiever ID
    private String receiever;
    // E-mail address for the receiever.
    private String type;
    // Type of the E-mail.
    private String role;
    // Role the user is gonna be changed to.
    private String password;
    // Password that the user used to login to the system, registration only.
    private final static String from = "dbpollgroupf@gmail.com";
    // Fixed sender E-mail(G-mail account).
    private final static String gmailPassword = "pass123123";
    // Fixed sender Password for G-mail.
    private final static int smtpPort = 465;
    // The port used to send the email.

   /**
     * Constructor.
     * @param user E-mail receiever ID
     * @param receiever E-mail address for the receiever.
     */
    public EmailService(String user, String receiever){

        this.user = user;
        this.receiever = receiever;
        this.type = "reset";

    }
    /**
     * Constructor.
     * @param user E-mail receiever ID
     * @param receiever E-mail address for the receiever.
     * @param role Role the user is gonna be changed to.
     */
    public EmailService(String user, String receiever, String role){

        this.user = user;
        this.receiever = receiever;
        this.role = role;
        this.type = "role";

    }
    /**
     * Constructor.
     * @param user E-mail receiever ID
     * @param receiever E-mail address for the receiever.
     * @param password Password that the user used to login to the system, registration only.
     * @param type Type of the E-mail.
     */
    public EmailService(String user, String receiever, String password, String type){

        this.user = user;
        this.receiever = receiever;
        this.password = password;
        this.type = type;

    }
    /**
     * Proccess the E-mail.
     * @throws AddressException
     * @throws MessagingException
     */
    public void send() throws AddressException
             , MessagingException {
        Properties props = new java.util.Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "" + smtpPort);
        props.put("mail.smtp.user", from);
        props.put("mail.smtp.password", gmailPassword);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.debug", "true");
        props.put("mail.smtps.starttls.enable", "true");
        props.put("mail.smtp.socketFactory.port", smtpPort);
		props.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");

        Session session = Session.getDefaultInstance(props,
            new GMailAuthenticator(from, gmailPassword));
        try {

            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(from));
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(receiever));
            msg.setSubject(subjectGenerator(type));
            msg.setText(contentGenerator(type));
            Transport.send(msg);
        }
        catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
    /**
     * Generates the subject of the E-mail.
     * @param type type of the report.
     * @return Subject of the Email in String format.
     */
    private String subjectGenerator(String type){

        String subject = "";
        if(type.equals("role")){
        //This is for role changed.
            subject =  "dbPoll - Role Changed Notification, No-Reply E-mail.";
        }
        else if (type.equals("reset")){
        //This is for password changed to a random 8-bits password.
            subject =  "dbPoll - Password Changed Notification, No-Reply E-mail.";
        }
        else{
            subject =  "dbPoll - User Registration Notification, No-Reply E-mail.";
        }

        return subject;
    }
    /**
     * Generates the content of the report.
     * @param type type of the report.
     * @return content for the report in String format.
     */
    private String contentGenerator(String type){
      String content = "Dear " + this.user + ",\n\n";
      if(type.equals("role")){
      //This is for role changed.
          content += "Your role in dbPoll system has been changed to " + this.role
                  + ".\n\n"
                  + "Thanks.\n\nKind Regards,\n\ndbPoll development team groupF.";

      }
      else if (type.equals("reset")){
      //This is for password changed.
          content += "Your password used to log into dbPoll system has been "
                  + "changed to a random password with 8 digits : "
                  + pwGenerator(8) + "\n\n"
                  + "Thanks.\n\nKind Regards,\n\ndbPoll development team groupF.";

      }

      else{
      //This is for registration.
           content += "You have been invited to dbPoll system, it's a system "
                   + "to help you to create questions in a particular poll for "
                   + "users in dbPoll to answer questions assigned to them.\n"
                   + "In this approach, you can get the responses from a ranged "
                   + "of users that you targeted quickly and effectively.\n"
                   + "There are of course many different usages which include "
                   + "get peolpe to answer questions during a presentaion or "
                   + "meeting.\n"
                   + "Please log into our lovely system to find out more information "
                   + "about dbPoll. \n\n"
                   + "Your username and password is listed below: \n\n"
                   + "Username: " + this.user + "\n"
                   + "Password: " + this.password + "\n\n"
                   + "Thanks.\n\nKind Regards,\n\ndbPoll development team groupF.";
      }
      return content;

    }
    /**
     * Generates the random password.
     * @param length length of the password reqired.
     * @return A random password with the length given
     */
    private String pwGenerator(int length) {
    char[] pw = new char[length];
    int c  = 'A';
    int  r1 = 0;
    for (int i=0; i < length; i++)
    {
      r1 = (int)(Math.random() * 3);
      switch(r1) {
        case 0: c = '0' +  (int)(Math.random() * 10); break;
        case 1: c = 'a' +  (int)(Math.random() * 26); break;
        case 2: c = 'A' +  (int)(Math.random() * 26); break;
      }
      pw[i] = (char)c;
    }
    return new String(pw).toLowerCase();

    }
    /**
     * A private class for GMail Authentication
     */
    private class GMailAuthenticator extends Authenticator {

        private String guser;
        private String gpassword;

        public GMailAuthenticator (String username, String password)
        {
        super();
        this.guser = username;
        this.gpassword = password;
        }

        public PasswordAuthentication getPasswordAuthentication()
        {
            return new PasswordAuthentication(guser, gpassword);
        }
    }
    
  // Self-testing.
  public static void main(String[] args) throws Exception {

     new EmailService("Andy", "s0956626962@hotmail.com").send();
     new EmailService("Andy", "s0956626962@hotmail.com", "Poll User").send();
     new EmailService("Andy", "s0956626962@hotmail.com", "pass123", "registration").send();
    
  }

}
