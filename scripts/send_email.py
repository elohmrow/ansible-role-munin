import smtplib
import email.message
import email.utils

def send_email(send_from, send_to):

    msg = email.message.Message()
    msg['From'] = send_from
    msg['To'] = send_to
    msg['Subject'] = "somethin bad wrong happened!"
    msg.add_header('Content-Type', 'text')
    msg.set_payload("I sent this from a python script.  I hope you like it.\n")

    smtp_obj = smtplib.SMTP("magnolia-cms.com")
    smtp_obj.sendmail(msg['From'], [msg['To']], msg.as_string())
    smtp_obj.quit()

send_email("bradley.andersen@magnolia-cms.com", "bradley.andersen@magnolia-cms.com,")
